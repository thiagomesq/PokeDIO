import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("PokeDIOModule", (m) => {
    const pokeDIO = m.contract("PokeDIO");

    return { pokeDIO };
});