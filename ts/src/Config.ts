
import { BaseFeature } from './feature/base/BaseFeature'
import { TestFeature } from './feature/test/TestFeature'



const FEATURE_CLASS: Record<string, typeof BaseFeature> = {
   test: TestFeature,

}


class Config {

  makeFeature(this: any, fn: string) {
    const fc = FEATURE_CLASS[fn]
    const fi = new fc()
    // TODO: errors etc
    return fi
  }


  main = {
    name: 'Vdraw',
  }


  feature = {
     test:     {
      "options": {
        "active": false
      }
    },

  }


  options = {
    base: "https://vdraw.ai/api",

    headers: {
      "content-type": "application/json"
    },

    entity: {
      
      username_generation: {
      },

    }
  }


  entity = {
    "username_generation": {
      "fields": [
        {
          "name": "suggestions",
          "type": "`$ARRAY`"
        },
        {
          "name": "username",
          "type": "`$STRING`"
        },
        {
          "name": "username_idea",
          "req": true,
          "type": "`$STRING`"
        }
      ],
      "name": "username_generation",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/username_generate",
              "parts": [
                "username_generate"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    }
  }
}


const config = new Config()

export {
  config
}

