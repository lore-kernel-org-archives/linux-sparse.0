From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] llvm: add script to display the deserialized LLVM IR
Date: Wed, 26 Apr 2017 04:43:28 +0800
Message-ID: <CANeU7Q=B=+j1YmbmH1=wkoxizVm0Tu8+PQLJQ5j_UMKv2n-V9g@mail.gmail.com>
References: <CACXZuxe9ioYu5fuZK=-iDdiL8RQpE37GvpE9s5DHjFYPCrKKfg@mail.gmail.com>
 <20170311115813.23249-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:38418 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934466AbdDYUn3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 25 Apr 2017 16:43:29 -0400
Received: by mail-it0-f53.google.com with SMTP id f187so21691405ite.1
        for <linux-sparse@vger.kernel.org>; Tue, 25 Apr 2017 13:43:29 -0700 (PDT)
In-Reply-To: <20170311115813.23249-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sat, Mar 11, 2017 at 7:58 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal is to use this in some of test cases, by comparing
> the expected output with the actual one.
>
> diff --git a/sparse-llvm-dis b/sparse-llvm-dis
> new file mode 100755
> index 000000000..573f8bbd0
> --- /dev/null
> +++ b/sparse-llvm-dis
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +
> +set +e
> +
> +DIRNAME=`dirname $0`
> +DIS=`"${LLVM_CONFIG:-llvm-config}" --bindir`/llvm-dis
> +
> +if [ $# -eq 0 ]; then
> +  echo "`basename $0`: no input files"
> +  exit 1
> +fi
> +
> +$DIRNAME/sparse-llvm $@ | $DIS

Looks good. You might want to check llvm-dis and sparse-llvm is
there. I assume this script will not be invoked if llvm is not there
so it is not a big deal.

Chris
