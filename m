From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 02/13] llvm: fix translation of PSEUDO_VALs into a ValueRefs
Date: Tue, 7 Mar 2017 23:11:20 +0800
Message-ID: <CANeU7Q=tPmE4wuCw7MN4kyru_eTCOrGG-kDd6azq0JQkimQ17w@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com> <20170305112047.3411-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35853 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755402AbdCGPj2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 10:39:28 -0500
Received: by mail-it0-f66.google.com with SMTP id w185so913109ita.3
        for <linux-sparse@vger.kernel.org>; Tue, 07 Mar 2017 07:38:48 -0800 (PST)
In-Reply-To: <20170305112047.3411-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sun, Mar 5, 2017 at 7:20 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> In sparse-llvm there is the assumption that a PSEUDO_VAL is always
> of integer type. But this is not always the case: constant pointers,
> like NULL, are also of the PSEUDO_VAL kind.

After apply this patch, the test suite has three more new test failure.
A closer look there are assert failed in three of the test cases.

error: actual error text does not match expected error text.
error: see backend/loop2.c.error.* for further investigation.
--- backend/loop2.c.error.expected 2017-03-07 23:06:42.298291232 +0800
+++ backend/loop2.c.error.got 2017-03-07 23:06:42.460291747 +0800
+sparse-llvm: sparse-llvm.c:312: val_to_value: Assertion `ctype' failed.
+.././sparsec: line 35:  8495 Aborted                 (core dumped)
$DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM


Also the previous 1/13 patch will generate warning without this path.

sparse-llvm.c:306:21: warning: =E2=80=98val_to_value=E2=80=99 defined but n=
ot used
[-Wunused-function]
 static LLVMValueRef val_to_value(struct function *fn, unsigned long
long val, struct symbol *ctype)
                     ^~~~~~~~~~~~
We should fix the warning. Maybe combine the previous patch with this one?

Chris
