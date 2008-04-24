From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: A few notes on how I see the whole process working.
Date: Fri, 25 Apr 2008 00:15:24 +0400
Message-ID: <f19298770804241315wca6a214x23a863c6fceb6009@mail.gmail.com>
References: <f19298770804202112hcd32b7ch8c6ef357b9f7344e@mail.gmail.com>
	 <480C8856.4030805@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:23340 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759056AbYDXUP2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 16:15:28 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2619959wff.4
        for <linux-sparse@vger.kernel.org>; Thu, 24 Apr 2008 13:15:27 -0700 (PDT)
In-Reply-To: <480C8856.4030805@kernel.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

Hello.

This discussion began in private, but we agreed that it would be better
to move it to the mailing list.

On Mon, Apr 21, 2008 at 4:28 PM, Josh Triplett <josh@kernel.org> wrote:
> Alexey Zaytsev wrote:
>  > Design.
>  >
>  >         When sparse is run as compiler by the build system,
>  > it creates a "sparse object" file, which name is derived from
>  > the output object file name, say file.o.sparse. When the
>  > sparse linker is run, the data from a number of input "sparse
>  > object" files is combined into the output "sparse object"
>  > file, associated with the resulting output object file,
>  > library or executable.
>
>  Sounds reasonable.  For the compile stage, cgcc could have sparse
>  generate file.o.sparse, and allow the real compiler to generate file.o
>  as it currently does.

Yes, this is what I was thinking about. Initially I did not aim at
preserving the real binary creation, but after realizing how easy
it is to implement it, I see no reason not doing it.

>
>
>  >         What data I see essential to be present in the "sparse
>  > object" files:
>  >
>  >         - A list of source files from which the sparse object
>  >           file was built, including for each file the following
>  >           data:
>  >                 - Path to the source file
>  >                 - Path to the build directory
>  >                 - Options passed to the compiler
>
>  How would these get used?
>

We need this data in order to be able to parse the source file,
should the symbol table user wish to.The first component is
obviously needed, the second and the third are needed to
resolve #includes and to pass the proper -D's.

>
>  >         - A list of required shared libraries.
>
>  How would this get used?
>

Well, to resolve the external symbols? The user would load the
symbol table file, see there are undefined symbols, and if he
wishes to look at them, he would locate the .sparse file associated
with the required library and load it too. Or do you propose to
add this data to the output file at the "link" time? Might work.
We will have to rebuild the whole thing after each shared library
change, though.

>
>  >         - A list of symbols, including for each symbol:
>  >                 - Name
>  >                 - Current section of residence, if defined.
>  >                 - Type
>  >                 - Scope
>  >                 - Address, if any assigned.
>
>  Sounds reasonable.
>
>
>  >                 - Pointer into the source file table, if the
>  >                   symbol originates from a source file or
>  >                   pointer into the shared library table.
>  >                   (or just null)
>
>  How would this get used?

This lets the user decide which symbols he wants to look at, and
parse the corresponding files.

>
>
>  >                 - (maybe something else I've missed?)
>
>  Most of the things in a sparse "struct symbol" would probably prove
>  useful, I suspect.
>
May be. I'm still not really familiar with the sparse internals.

>  Eventually we will probably want something like the linearized
>  bytecode.
>

While I generally agree the we need to do something like

sparse -> intermediate data -> checker

the intermediate format is a bit unclear to me. It has to be verbose
enough to loose no essential information, and still be practical.
If by linearized bytecode you mean something like what we get
running sparse -ventry, this is clearly not going to work. As an
example, suppose you wish to check that local_irqsave() and
local_irqrestore() are balanced. This means, the checker actually
wants to look at the original source code, not even at the
pre-processed C code.

So, suggestions on the intermediate format are welcome.

>
>  >         This should work for object files, executables and shared
>  > libraries. And it should be trivial to extend the idea to work for
>  > static libraries.
>
>  You mean that you want to build libfoo.so.sparse, libfoo.a.sparse,
>  foo.sparse, and so on?  That sounds good.
>

Yes, for any output binary, we should provide a .sparse file.

>
>  >         An other option was to include the data into the binaries,
>  > probably into some new section.
>
>  Right, the approach which has come up on the list a few times, and
>  which we talked about in the comments on your SoC proposal.
>
>
>  > This approach lets you automatically
>  > get the sparse symbol tables, associated with the built libraries,
>  > installed into your system. Without even touching the build
>  > environment. But I'm not sure it is worth the added complexity. The
>  > symbol table should be appended to any object file built, and then
>  > extracted every time the object files are built into libraries or
>  > executables, and recreated anew. Also this would embarrass the
>  > linker debugging, as it gets harder to look at the generated symbol
>  > tables, and even non-trivial to tell if a binary has an associated
>  > symbol table. And in the end, we still need to keep the source tree
>  > around, as the symbol tables alone are not enough to perform any
>  > useful checks.
>  >         Maybe when we agree on some intermediate format to store
>  > the parsed file data, it would be worth appending this data to the the
>  > symbol table and include the result into the binary to be able to throw
>  > away the source tree. This needs further evaluation, so I'll take the
>  > easy path until things get certain.
>
>  I agree that this approach does not necessarily seem worthwhile.  Your
>  proposal to build *.sparse files seems simpler and yet equally
>  functional.
>
>  However, you mentioned that "we still need to keep the source tree
>  around, as the symbol tables alone are not enough to perform any
>  useful checks."; why not just write out the necessary information,
>  rather than re-parsing the source tree?
>
>  Note that we don't need to have some agreed-upon intermediate format;
>  for now, anything the Sparse compiler can write and the Sparse linker
>  can read will do, and I see no need to standardize it right now.
>
Yes, see above. This is what I hope will eventually happen. The question
is, when?

>
>  > Implementation.
>  >
>  >         Just some wild idea. We can let sparse, when run as the
>  > compiler, generate C code, with structures containing the "sparse
>  > object" data, like.
>  >
>  > struct sparse_file {
>  >         char *file_path;
>  >         char *build_path;
>  >         char *build_options;
>  > };
>  >
>  > struct sparse_symbol {
>  >         char *name;
>  >         char *section;
>  >         struct sparse_file *file;
>  >         ...
>  > };
>  >
>  > struct sparse_file *file_list = {
>  >         {
>  >                 ...
>  >         },
>  > };
>  >
>  > struct sparse_symbol *symbol_list = {
>  >         {
>  >                 ...
>  >         },
>  >         {
>  >                 ...
>  >         },
>  > };
>  >
>  >         The cgcc then could call the host compiler to build a shared
>  > library from the generated code. A consumer could use dlopen() to
>  > access the data in an efficient way. The "sparse linker", when run
>  > on the "sparse object" files, would collect the data from the input
>  > files, and build the output tables, just like a binary linker does.
>  > With this approach, the consumer will get the data in the most
>  > efficient and simple way. No need to parse the symbol tables. With
>  > some object naming tricks, we could even make ld.so resolve all the
>  > dependencies, but I'd like to keep the flexibility and resolve them
>  > manually.
>
>  Not a bad idea.  I'd suggest proposing it to the Sparse list to see
>  what others think.
>
>  On the other hand, it doesn't seem that difficult to just write out
>  all the structures to a file and read them back in.  This wouldn't
>  require parsing, just input and output of binary structures.
>

This would limit us only to structures containing no pointers. If we are going
to follow the pointers, this is not much different from generating C code.
And the C code has the benefit of being human-readable, so you could
use a text editor to look at the generated symbol tables, which I'm sure will
turn very handy for debugging the linker.

>
>  > On the time line.
>  >
>  > As I said, I expect this work to take no more than a month. But I'll
>  > be paragliding in Ukraine from around April 28 - May 11, and then
>  > there will be time to prepare for the exams. So I'd expect some
>  > working code towards the end of May, and a fully functional version
>  > somewhere in July (assuming I won't screw my neck while on the
>  > vacation ;). Ok?

s/July/June/ of course.

>
>  That sounds reasonable, since the official "start of coding" date
>  occurs on May 26th.  However, I'd like to see a rough prototype
>  earlier rather than later.  Please note that starting no later than
>  May 26th, I'd like to hear from you at least once a week about how
>  your project goes.

One think that could take some time might be the linker script parsing.
Probably will have to learn yacc. Any suggestions?

>
>  Good luck with your project and with your paragliding.
>
>  - Josh Triplett
>
>
