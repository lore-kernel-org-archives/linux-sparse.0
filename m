From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm variadic functions are not being marked as variadic
Date: Sun, 19 Mar 2017 16:29:36 +0100
Message-ID: <20170319152935.fguutzmbskxkwghv@macpro.local>
References: <CACXZuxeNcbNhM0A6Z0r2fnoDh8d5f9ymabZtouD8DMxcaMDA8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37605 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbdCSP3j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:29:39 -0400
Received: by mail-wm0-f54.google.com with SMTP id n11so47534827wma.0
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:29:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxeNcbNhM0A6Z0r2fnoDh8d5f9ymabZtouD8DMxcaMDA8Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 14, 2017 at 11:30:49AM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> It appears that when a function is compiled, its variadic flag is not
> being set in LLVM so LLVM complains when at call sites variable
> arguments are passed.
> 
> The fix requires a change in output_fn() in sparse-llvm.c:
> 
> function.type = LLVMFunctionType(return_type, arg_types, nr_args,
> base_type->variadic);

Applied in the llvm-fixes-v3 serie I submitted yesterday.

-- Luc
