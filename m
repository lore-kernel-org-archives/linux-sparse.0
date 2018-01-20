From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: make data-structures.txt easier to read
Date: Sat, 20 Jan 2018 15:49:15 -0800
Message-ID: <0db75caa-21ef-c5c9-2ae6-63cb115d1c1f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:54101 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeATXtR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 20 Jan 2018 18:49:17 -0500
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>

From: Randy Dunlap <rdunlap@infradead.org>

Make this file easier to read by removing the name at the beginning
of each line.
Put its source and attribution at the beginning of the file.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/data-structures.txt |  107 ++++++++++++++--------------
 1 file changed, 54 insertions(+), 53 deletions(-)

--- sprs-2018-0119.orig/Documentation/data-structures.txt
+++ sprs-2018-0119/Documentation/data-structures.txt
@@ -1,54 +1,55 @@
+- A slightly edited irc discussion with Josh Triplett.
+- Describes most data structures used in sparse.
 
-<JoshTriplett> As far as the parsing structures go...
-<JoshTriplett> The C parser exists in two main files: parse.c, which parses statements, and expression.c, which parses expressions.
-<JoshTriplett> parse.h contains the definition of struct statement, which represents a C statement.
-<JoshTriplett> That includes only those things which can't appear as an expression, which primarily includes control flow statements such as if, loops, switch/case, and goto.
-<JoshTriplett> expression.h contains the definition of struct expression, which represents a C expression.  That has a lot more content, since most C constructs can appear in expressions.
-<JoshTriplett> A series of statements forms a compound statement (STMT_COMPOUND).
-<JoshTriplett> That appears as another struct statement which has a statement_list member.
-<JoshTriplett> A function body consists of a compound statement.
-<JoshTriplett> When you look at a loop body, if or else body, or case body, you'll notice that they just have a struct statement, not a statement_list; they can have multiple statements by using a compound statement.
-<JoshTriplett> Also note that all loops get turned into a single "iterator" statement.
-<JoshTriplett> for, while, and do-while.
-<JoshTriplett> A symbol, then, represents a name in a C file.  A symbol might represent a variable, a function, a label, or various other things.
-<JoshTriplett> See symbol.h.
-<JoshTriplett> "struct symbol" represents one symbol.
-<JoshTriplett> As with the various other structures, it has some common data and a union of sub-structures for the parts that differ between different types.
-<JoshTriplett> Most of the interesting bits come in the NS_SYMBOL case.
-<JoshTriplett> Among other things, it has a struct statement for the body of a function (if any), a list of symbols for the arguments, an expression for a variable initializer, and so on.
-<JoshTriplett> Together, struct symbol, struct statement, and struct expression represent most of the abstract syntax tree for C.
-<JoshTriplett> So, that represents most of the "front-end" of Sparse: parsing C and generating that abstract syntax tree.
-<JoshTriplett> That much occurs in pretty much any program using the Sparse frontend.
-<JoshTriplett> The backend varies among programs.
-<JoshTriplett> For instance, the c2xml backend goes that far, then outputs XML.
-<JoshTriplett> The sparse static analysis backend has a few steps: it generates linearized bytecode, does some evaluation on that, and outputs some warnings.
-<JoshTriplett> Several other backends run that linearized bytecode stage.
-<JoshTriplett> The linearized bytecode itself has a set of nested structures.
-<JoshTriplett> linearize.h defines all of them.
-<JoshTriplett> At the top level, it has struct entrypoint.
-<JoshTriplett> That represents an entrypoint to the code, which would normally mean a function.
-<JoshTriplett> An entrypoint has a list of basic blocks.
-<JoshTriplett> struct basic_block.
-<JoshTriplett> A basic block represents a series of instructions with no branches.
-<JoshTriplett> Straight-line code.
-<JoshTriplett> A branch only occurs at the end of a basic block, and branches can only target the beginning of a basic block.
-<JoshTriplett> Typically, a conditional will consist of a basic block leading up to the branch, a basic block for the true case, a basic block for the false case, and a basic block where the two paths merge back together.
-<JoshTriplett> Either the true or the false case may not exist.
-<JoshTriplett> A loop will normally have a basic block for the loop body, which can branch to the top at the end or continue to the next basic block.
-<JoshTriplett> So basic blocks represent a node in the control flow graph.
-<JoshTriplett> The edges in that graph lead from one basic block to a basic block which can follow it in the execution of the program.
-<JoshTriplett> Each basic block has a series of instructions, "struct instruction".
-<JoshTriplett> "enum opcode" lists all the instructions.
-<JoshTriplett> Fairly high-level instruction set, corresponding directly to bits of C.
-<JoshTriplett> So you have an entrypoint, which has a graph of basic blocks, each of which has a list of instructions.
-<JoshTriplett> An entrypoint also has a pointer to the first instruction.
-<JoshTriplett> One last bit of trickiness: struct pseudo.
-<JoshTriplett> Have you ever heard of "static single assignment" or SSA form?
-<JoshTriplett> struct pseudo represents one of those single-assignment variables.
-<JoshTriplett> Each one has a pointer to the symbol it represents (which may have many pseudos referencing it).
-<JoshTriplett> Each one also has a pointer to the instruction that defines it.
-<JoshTriplett> That covers most of the major data structures in Sparse.
-<JoshTriplett> Now, given all that, some of the top-level stuff in sparse.c may make more sense.
-<JoshTriplett> For instance, the context checking works in terms of basic blocks.
-<JoshTriplett> Hopefully some of that helped you understand Sparse better.
-
+As far as the parsing structures go...
+The C parser exists in two main files: parse.c, which parses statements, and expression.c, which parses expressions.
+parse.h contains the definition of struct statement, which represents a C statement.
+That includes only those things which can't appear as an expression, which primarily includes control flow statements such as if, loops, switch/case, and goto.
+expression.h contains the definition of struct expression, which represents a C expression.  That has a lot more content, since most C constructs can appear in expressions.
+A series of statements forms a compound statement (STMT_COMPOUND).
+That appears as another struct statement which has a statement_list member.
+A function body consists of a compound statement.
+When you look at a loop body, if or else body, or case body, you'll notice that they just have a struct statement, not a statement_list; they can have multiple statements by using a compound statement.
+Also note that all loops get turned into a single "iterator" statement.
+for, while, and do-while.
+A symbol, then, represents a name in a C file.  A symbol might represent a variable, a function, a label, or various other things.
+See symbol.h.
+"struct symbol" represents one symbol.
+As with the various other structures, it has some common data and a union of sub-structures for the parts that differ between different types.
+Most of the interesting bits come in the NS_SYMBOL case.
+Among other things, it has a struct statement for the body of a function (if any), a list of symbols for the arguments, an expression for a variable initializer, and so on.
+Together, struct symbol, struct statement, and struct expression represent most of the abstract syntax tree for C.
+So, that represents most of the "front-end" of Sparse: parsing C and generating that abstract syntax tree.
+That much occurs in pretty much any program using the Sparse frontend.
+The backend varies among programs.
+For instance, the c2xml backend goes that far, then outputs XML.
+The sparse static analysis backend has a few steps: it generates linearized bytecode, does some evaluation on that, and outputs some warnings.
+Several other backends run that linearized bytecode stage.
+The linearized bytecode itself has a set of nested structures.
+linearize.h defines all of them.
+At the top level, it has struct entrypoint.
+That represents an entrypoint to the code, which would normally mean a function.
+An entrypoint has a list of basic blocks.
+struct basic_block.
+A basic block represents a series of instructions with no branches.
+Straight-line code.
+A branch only occurs at the end of a basic block, and branches can only target the beginning of a basic block.
+Typically, a conditional will consist of a basic block leading up to the branch, a basic block for the true case, a basic block for the false case, and a basic block where the two paths merge back together.
+Either the true or the false case may not exist.
+A loop will normally have a basic block for the loop body, which can branch to the top at the end or continue to the next basic block.
+So basic blocks represent a node in the control flow graph.
+The edges in that graph lead from one basic block to a basic block which can follow it in the execution of the program.
+Each basic block has a series of instructions, "struct instruction".
+"enum opcode" lists all the instructions.
+Fairly high-level instruction set, corresponding directly to bits of C.
+So you have an entrypoint, which has a graph of basic blocks, each of which has a list of instructions.
+An entrypoint also has a pointer to the first instruction.
+One last bit of trickiness: struct pseudo.
+Have you ever heard of "static single assignment" or SSA form?
+struct pseudo represents one of those single-assignment variables.
+Each one has a pointer to the symbol it represents (which may have many pseudos referencing it).
+Each one also has a pointer to the instruction that defines it.
+That covers most of the major data structures in Sparse.
+Now, given all that, some of the top-level stuff in sparse.c may make more sense.
+For instance, the context checking works in terms of basic blocks.
+Hopefully some of that helped you understand Sparse better.

