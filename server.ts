import { Application, Router } from "https://deno.land/x/oak/mod.ts";
const { readFile, writeFile } = Deno;

const options = { hostname: '10.237.188.45', port: 3400 };


const app = new Application();
const router = new Router();

class Article {

  public id = '';
  public title = '';
  public author = '';
  public content = '';
  public thumbs = 0;
  public coins = 0;
  public favors = 0;

  constructor({
    id = '',
    title = '',
    author = '',
    content = '',
    thumbs = 0, coins = 0, favors = 0
  }) {
    console.log(id);
    this.id = id;
    this.title = title;
    this.author = author;
    this.content = content;
    this.thumbs = thumbs;
    this.coins = coins;
    this.favors = favors;
  }

}

enum ActionType {
  THUMB, COIN, FAVOR
}

router
  .post('/signin', async (ctx) => {
    const { user, password } = await ctx.request.body({
      type: 'json'
    }).value;
    console.log({ user, password });
    ctx.response.body = {
      status: 'SUCCESS',
    };
  })
  .get('/articles', async (ctx) => {
    const articles = await readFileTransformer('./assets/data/articles.json');
    console.log(articles);
    ctx.response.body = {
      status: 'SUCCESS',
      articles
    };
  })
  .post('/articles', async (ctx) => {
    const articles = await readFileTransformer('./assets/data/articles.json');
    const id = articles.length + 1;
    const newValue = await ctx.request.body({
      type: 'json'
    }).value;
    // console.log(newValue);
    const newArticle = new Article({
      ...newValue,
      id: id.toString()
    });
    console.log(newArticle);
    articles.push(newArticle);
    await writeFileTransformer('./assets/data/articles.json', articles);
    ctx.response.body = {
      status: 'SUCCESS',
    };
  })
  .get('/articles/:id', async (ctx) => {
    const { id } = ctx.params;
    const articles = await readFileTransformer('./assets/data/articles.json');
    const article = articles.find((item: Article) => item.id === id);
    console.log(article);
    ctx.response.body = {
      status: 'SUCCESS',
      article: article ?? null
    };
  })
  .put('/articles/:id', async (ctx) => {
    const { id } = ctx.params;
    const newValue = await ctx.request.body({
      type: 'json'
    }).value;
    const oldArticles = await readFileTransformer('./assets/data/articles.json');
    const newArticles = oldArticles.map((article: any) => {
      if (article.id === id) {
        return {
          ...article,
          ...newValue
        };
      }
      return article;
    });
    console.log(newArticles);
    await writeFileTransformer('./assets/data/articles.json', newArticles);
    ctx.response.body = {
      status: 'SUCCESS',
    };
  })
  .put('/:type/:id', async (ctx) => {
    const { type = '', id } = ctx.params;
    console.log({ type, id });
    const oldArticles = await readFileTransformer('./assets/data/articles.json');
    const newArticles = oldArticles.map((article: Article) => {
      if (article.id === id) {
        return {
          ...article,
          [type]: article[type as keyof Article] as number + 1
        };
      }
      return article;
    });
    console.log(newArticles);
    await writeFileTransformer('./assets/data/articles.json', newArticles);
    ctx.response.body = {
      status: 'SUCCESS',
    };
  })

app.use(router.routes());
app.use(router.allowedMethods());
console.log(`Server running at http://${ options.hostname }:${ options.port }`);
await app.listen(options);

async function readFileTransformer(path: string): Promise<any> {
  const decoder = new TextDecoder('utf-8');
  const dataArray = await readFile(path);
  return JSON.parse(decoder.decode(dataArray));
}

async function writeFileTransformer(path: string, data: any): Promise<void> {
  const encoder = new TextEncoder();
  await writeFile(path, encoder.encode(JSON.stringify(data)));
}



