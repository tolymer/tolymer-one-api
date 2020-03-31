const resolvers = {
  Query: {
    getEvent: (_parent: any, args: any) => {
      return { token: args.token };
    }
  }
};

export default resolvers;
