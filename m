From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/3] Makefile: Fix some macro redefinition warnings
Date: Fri, 17 May 2013 11:30:10 -0700
Message-ID: <51967732.40302@chrisli.org>
References: <519536B5.7020603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55392 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628Ab3EQSaR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 17 May 2013 14:30:17 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so3834667pad.2
        for <linux-sparse@vger.kernel.org>; Fri, 17 May 2013 11:30:16 -0700 (PDT)
In-Reply-To: <519536B5.7020603@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 05/16/2013 12:42 PM, Ramsay Jones wrote:
> 
> In particular, gcc complains as follows:
> 
>        CC       sparse-llvm.o
>   <command line>:1:1: warning: "__STDC_CONSTANT_MACROS" redefined
>   <command line>:1:1: warning: this is the location of the previous definition
>   <command line>:1:1: warning: "__STDC_FORMAT_MACROS" redefined
>   <command line>:1:1: warning: this is the location of the previous definition
>   <command line>:1:1: warning: "__STDC_LIMIT_MACROS" redefined
>   <command line>:1:1: warning: this is the location of the previous definition
> 
> The warnings are caused by the macros being defined twice on the
> gcc command line. These command line -D macro definitions come
> originally from the output of 'llvm-config --cflags', which is
> recorded in the $(LLVM_CFLAGS) variable. This variable is then
> included in the $(BASIC_CFLAGS) variable twice due to duplication
> of the target-specific additions to the BASIC_CFLAGS, viz:
> 
>   sparse-llvm_EXTRA_DEPS := sparse-llvm.o
>   sparse-llvm.o $(sparse-llvm_EXTRA_DEPS): BASIC_CFLAGS += $(LLVM_CFLAGS)
> 
> In order to suppress the warnings, we remove the duplication of
> the sparse-llvm.o target in the above rule.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

I already commit a similar fix to remove the duplication.
I did not realize it can generate warning though.

Chris
