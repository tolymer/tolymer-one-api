import fs from "fs";
import { ApolloServer } from "apollo-server";
import resolvers from "./resolvers";

const typeDefs = fs.readFileSync("./schema.graphql", "utf8");
const server = new ApolloServer({ typeDefs, resolvers });

server.listen(process.env.PORT || "8000").then(({ url }) => {
  console.log(`🚀 Server ready at ${url}`);
});
