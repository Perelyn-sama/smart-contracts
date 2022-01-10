const Amm = artifacts.require("Amm");

contract("Amm", () => {
  let amm = null;

  before(async () => {
    amm = await Amm.deployed();
  });

  it("should add new id to array", async () => {
    let id = 10;

    await advancedStorage.add(id);
    const result = await advancedStorage.ids(0);
    assert(result.toNumber() == id);
  });
});
