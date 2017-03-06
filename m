From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] give a type to OP_PHISOURCE
Date: Mon, 6 Mar 2017 10:27:26 +0800
Message-ID: <CANeU7Qn-m=7F1OQKk+pYQzSNpx3e5AOnuQENbG7bz=1BjoQ3Qw@mail.gmail.com>
References: <20170303095421.39740-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35197 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbdCFC12 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 21:27:28 -0500
Received: by mail-it0-f67.google.com with SMTP id 203so8171298ith.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 18:27:27 -0800 (PST)
In-Reply-To: <20170303095421.39740-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Fri, Mar 3, 2017 at 5:54 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Currently, OP_PHISOURCEs are given a size but not a type.
>
> There is no good reasons fro that and it complicate the
> further correct processing or make it impossible.
>
> CC: Dibyendu Majumdar <mobile@majumdar.org.uk>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

I am looking at the llvm patches right now.

These four has similar names in the 13 patches so I assume
they can be safely dropped.

9602773-give-a-type-to-OP_PHISOURCE.patch
9602515-give-a-type-to-OP_SEL-always.patch
9602771-llvm-add-support-for-OP_NEG.patch
9603553-llvm-fix-do-not-mix-pointers-and-floats-when-doing-compares.patch

I am not sure about this two. Should I skip them?

# 9599615-llvm-fix-getting-type-of-values.patch
# 9601521-llvm-stores-does-not-create-or-modify-their-target.patch

Here is the 13 llvm patches I have in my queue.

9604553-01-13-llvm-add-a-helper-to-convert-an-integer-to-a-ValueRef.patch
9604547-02-13-llvm-fix-translation-of-PSEUDO_VALs-into-a-ValueRefs.patch
9604559-03-13-llvm-fix-output_op_store-which-modify-its-operand.patch
9604543-04-13-llvm-fix-output_op_-ptr-cast.patch
9604555-05-13-add-get_nth1_arg.patch
9604557-06-13-llvm-fix-type-of-literal-integer-passed-as-arguments.patch
9604545-07-13-llvm-fix-output-OP_ADD-mixed-with-pointers.patch
9604535-08-13-llvm-add-support-for-OP_NEG.patch
9604537-09-13-give-a-type-to-OP_PHISOURCE.patch
9604549-10-13-give-a-type-to-OP_SEL-always.patch
9604541-11-13-llvm-remove-unneeded-arg-module.patch
9604539-12-13-llvm-remove-unneeded-arg-fn.patch
9604551-13-13-llvm-fix-do-not-mix-pointers-and-floats-when-doing-compares.patch

Chris
