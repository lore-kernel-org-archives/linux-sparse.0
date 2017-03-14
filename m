From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm variadic functions are not being marked as variadic
Date: Tue, 14 Mar 2017 11:30:49 +0000
Message-ID: <CACXZuxeNcbNhM0A6Z0r2fnoDh8d5f9ymabZtouD8DMxcaMDA8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36051 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdCNLav (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 07:30:51 -0400
Received: by mail-io0-f169.google.com with SMTP id l7so102078088ioe.3
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 04:30:50 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

It appears that when a function is compiled, its variadic flag is not
being set in LLVM so LLVM complains when at call sites variable
arguments are passed.

The fix requires a change in output_fn() in sparse-llvm.c:

function.type = LLVMFunctionType(return_type, arg_types, nr_args,
base_type->variadic);

Thanks and Regards
Dibyendu
