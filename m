From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 14/15] A slightly edited irc discussion with Josh Triplett.
Date: Mon, 15 Dec 2008 03:27:47 +0300
Message-ID: <20081215002747.16107.66575.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:30203 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbYLOASg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:18:36 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1056550fgg.17
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:18:34 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

Describes most data srtructures used in sparse.
---
 Documentation/data-structures.txt |   54 +++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/data-structures.txt

diff --git a/Documentation/data-structures.txt b/Documentation/data-structures.txt
new file mode 100644
index 0000000..3745b54
--- /dev/null
+++ b/Documentation/data-structures.txt
@@ -0,0 +1,54 @@
+
+<JoshTriplett> As far as the parsing structures go...
+<JoshTriplett> The C parser exists in two main files: parse.c, which parses statements, and expression.c, which parses expressions.
+<JoshTriplett> parse.h contains the definition of struct statement, which represents a C statement.
+<JoshTriplett> That includes only those things which can't appear as an expression, which primarily includes control flow statements such as if, loops, switch/case, and goto.
+<JoshTriplett> expression.h contains the definition of struct expression, which represents a C expression.  That has a lot more content, since most C constructs can appear in expressions.
+<JoshTriplett> A series of statements forms a compound statement (STMT_COMPOUND).
+<JoshTriplett> That appears as another struct statement which has a statement_list member.
+<JoshTriplett> A function body consists of a compound statement.
+<JoshTriplett> When you look at a loop body, if or else body, or case body, you'll notice that they just have a struct statement, not a statement_list; they can have multiple statements by using a compound statement.
+<JoshTriplett> Also note that all loops get turned into a single "iterator" statement.
+<JoshTriplett> for, while, and do-while.
+<JoshTriplett> A symbol, then, represents a name in a C file.  A symbol might represent a variable, a function, a label, or various other things.
+<JoshTriplett> See symbol.h.
+<JoshTriplett> "struct symbol" represents one symbol.
+<JoshTriplett> As with the various other structures, it has some common data and a union of sub-structures for the parts that differ between different types.
+<JoshTriplett> Most of the interesting bits come in the NS_SYMBOL case.
+<JoshTriplett> Among other things, it has a struct statement for the body of a function (if any), a list of symbols for the arguments, an expression for a variable initializer, and so on.
+<JoshTriplett> Together, struct symbol, struct statement, and struct expression represent most of the abstract syntax tree for C.
+<JoshTriplett> So, that represents most of the "front-end" of Sparse: parsing C and generating that abstract syntax tree.
+<JoshTriplett> That much occurs in pretty much any program using the Sparse frontend.
+<JoshTriplett> The backend varies among programs.
+<JoshTriplett> For instance, the c2xml backend goes that far, then outputs XML.
+<JoshTriplett> The sparse static analysis backend has a few steps: it generates linearized bytecode, does some evaluation on that, and outputs some warnings.
+<JoshTriplett> Several other backends run that linearized bytecode stage.
+<JoshTriplett> The linearized bytecode itself has a set of nested structures.
+<JoshTriplett> linearize.h defines all of them.
+<JoshTriplett> At the top level, it has struct entrypoint.
+<JoshTriplett> That represents an entrypoint to the code, which would normally mean a function.
+<JoshTriplett> An entrypoint has a list of basic blocks.
+<JoshTriplett> struct basic_block.
+<JoshTriplett> A basic block represents a series of instructions with no branches.
+<JoshTriplett> Straight-line code.
+<JoshTriplett> A branch only occurs at the end of a basic block, and branches can only target the beginning of a basic block.
+<JoshTriplett> Typically, a conditional will consist of a basic block leading up to the branch, a basic block for the true case, a basic block for the false case, and a basic block where the two paths merge back together.
+<JoshTriplett> Either the true or the false case may not exist.
+<JoshTriplett> A loop will normally have a basic block for the loop body, which can branch to the top at the end or continue to the next basic block.
+<JoshTriplett> So basic blocks represent a node in the control flow graph.
+<JoshTriplett> The edges in that graph lead from one basic block to a basic block which can follow it in the execution of the program.
+<JoshTriplett> Each basic block has a series of instructions, "struct instruction".
+<JoshTriplett> "enum opcode" lists all the instructions.
+<JoshTriplett> Fairly high-level instruction set, corresponding directly to bits of C.
+<JoshTriplett> So you have an entrypoint, which has a graph of basic blocks, each of which has a list of instructions.
+<JoshTriplett> An entrypoint also has a pointer to the first instruction.
+<JoshTriplett> One last bit of trickiness: struct pseudo.
+<JoshTriplett> Have you ever heard of "static single assignment" or SSA form?
+<JoshTriplett> struct pseudo represents one of those single-assignment variables.
+<JoshTriplett> Each one has a pointer to the symbol it represents (which may have many pseudos referencing it).
+<JoshTriplett> Each one also has a pointer to the instruction that defines it.
+<JoshTriplett> That covers most of the major data structures in Sparse.
+<JoshTriplett> Now, given all that, some of the top-level stuff in sparse.c may make more sense.
+<JoshTriplett> For instance, the context checking works in terms of basic blocks.
+<JoshTriplett> Hopefully some of that helped you understand Sparse better.
+

