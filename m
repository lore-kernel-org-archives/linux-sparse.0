From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/2] Documents: project ideas
Date: Thu, 10 Aug 2017 12:42:43 -0700
Message-ID: <9cc6504c-fa18-3b6a-132b-5797551d48ac@infradead.org>
References: <CANeU7Qm5czpkmaswwhqyXZn95-eeU-7SM6+uEUBqUh64oEVRKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43040 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbdHJTmr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 15:42:47 -0400
In-Reply-To: <CANeU7Qm5czpkmaswwhqyXZn95-eeU-7SM6+uEUBqUh64oEVRKQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On 08/09/2017 08:30 PM, Christopher Li wrote:
> Adding project idea to improve sparse.
> 
> Signed-off-by: Christopher Li <sparse@chrisli.org>
> ---
>  Documentation/project-ideas.md | 52 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/project-ideas.md
> 
> diff --git a/Documentation/project-ideas.md b/Documentation/project-ideas.md
> new file mode 100644
> index 0000000..9adce20
> --- /dev/null
> +++ b/Documentation/project-ideas.md
> @@ -0,0 +1,52 @@
> +Why hacking on sparse
> +=====================
> +
> +1. sparse is small.
> +   The full project compiles in less than * seconds on old and not
> performing laptop.
> +2. sparse is fast.
> +   Typically, sparse can check on C file ** of time it take for gcc

                        can check a C file in ** of the time it takes for gcc

> to generate object files.
> +3. sparse can digest the full kernel source file.

                                               files.

> +   With sparse-llvm, sparse use llvm as back end to emit real machine code.

                               uses

> +
> +New developer hacking on sparse
> +==============================
> +
> +
> +* Sparse all sparse warning message should include the option how

   * All sparse warning messages

> +   to disable it.
> +       e.g. "pre-process.c:20*:28: warning: Variable length array is used."
> +       should be something like
> +        "pre-process.c:20*:28: warning: Variable length array is
> +used. (-Wno-vla)"
> +* extend test-inspect to inspect more AST fields.
> +* Addd inspect to inspect instructions.

   * Add

> +* adding architecture handling in sparse similar to cgcc
> +* parallel processing of test-suit

?                           test suite

> +* Howto: fix the kernel rcu related checker warnings
> +* option to disable AST level inline.
> +* debug: debug version of sparse do all the verification double
> +* testsuit: verify and compare IR (suggested by Dibyendu Majumdar)

     test suite:

> +
> +For experienced developers
> +==========================
> +
> +* merge C type on incremental declare of C type and function prototype.
> +* move attribute out of ctype to allow easier to add new attribute.
> +* serialize, general object walking driven by data structures.
> +* serialize, write sparse byte code into file
> +* serialize, load sparse byte code from file.
> +* symbol index/linker, know which symbol in which byte code file.
> +* inline function in instruction level
> +* cross function checking
> +* checker error output database
> +* debug: optimization step by step log
> +* debug: fancy animation of CFG
> +* phi node location (Luc has patch)
> +* revisit crazy programmer warning, invalid SSA form.
> +* ptrlist, looping while modify inside the loop.
> +* dead code eliminate using ssa

               elimination

> +* constant propagation using ssa.
> +* x86/arm back end instruction set define
> +* register allocation.
> +* emit x86/arm machine level code
> +
> 


-- 
~Randy
