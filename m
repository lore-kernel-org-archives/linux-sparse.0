From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Wed, 23 Nov 2016 09:23:45 +0800
Message-ID: <CANeU7Q=UzPTfKNNBMsgrimBLmWC2UMRfyXkO=9NHL6ES4S4N7g@mail.gmail.com>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net> <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
 <20161122131543.GA8370@macbook.local> <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
 <20161122171224.GA4146@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35961 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755872AbcKWBXs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 20:23:48 -0500
Received: by mail-io0-f196.google.com with SMTP id k19so13881520iod.3
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 17:23:48 -0800 (PST)
In-Reply-To: <20161122171224.GA4146@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Wed, Nov 23, 2016 at 1:12 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> I think I have been catch up with most of the patches.
> Yes, just from memory, there is still one from Oleg, about dissect.

Another observation is that, the review order does not change how
much time it need to review the patches.

Here is my current pending list other than the constant integer expression
series.

Chris

8249571-dissect-teach-do_expression-to-handle-EXPR_OFFSETOF.patch
8250741-dissect-teach-do_initializer-to-handle-the-nested-EXPR_IDENTIFIER-s.patch
8258041-v3-sparse-add-support-for-static-assert.patch
8285451-dissect-s-mode_t-usage_t-in-report_member.patch
8335781-FAIL-1-5-parse-Add-comment-to-struct-statement.patch
8335791-FAIL-3-5-linearize-Add-context-symbol-name-when-showing-context-instructions.patch
8335811-FAIL-5-5-test-locks-Add-lock-tester.patch
8335821-FAIL-4-5-parse-Add-acquire-release-requires-and-guarded_by-attributes.patch
8335851-FAIL-2-5-inspect-Show-context-information.patch
8655361-1-2-compiler.h-add-support-for-malloc-attribute.patch
9013811-2-2-validation-Check-C99-for-loop-variables.patch

9428345-RFC-bits_in_bool-should-be-8.patch

9434581-7-8-explicitely-ignore-killing-OP_ENTRY.patch
9434607-3-5-testsuite-report-as-error-tests-known-to-fail-but-which-succeed.patch
9434617-8-8-cleanup-kill_instruction.patch
9434767-1-2-add-missing-PACK_PTR_LIST.patch
9434769-2-2-mark-lists-to-be-repacked-as-dirty.patch
9434773-4-8-fix-killing-OP_CAST-friends.patch
9435027-6-8-fix-killing-OP_COMPUTEDGOTO.patch
9435155-5-8-fix-killing-OP_SELECT.patch
9435157-3-8-fix-killing-OP_PHI-instructions.patch
9435159-1-8-kill-uses-of-replaced-instructions.patch
9435161-2-8-fix-killing-OP_SETVAL-instructions.patch
9435305-0-2-be-more-generous-with-ptrlist-repacking.patch
