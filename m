From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v6 00/15] prepare for LLVM fixes
Date: Mon, 27 Mar 2017 22:56:52 +0100
Message-ID: <7406f777-5e8b-5ae0-55e0-26a36ddb64b5@ramsayjones.plus.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:54564 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbdC0V4y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:56:54 -0400
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>



On 27/03/17 18:33, Luc Van Oostenryck wrote:
> This serie contains preparatory patches for
> sparse-llvm's fixes but not sparse-llvm specific
> and having some values of their own.
> 
> These patches were extracted from a previous
> serie containing also the sparse-llvm patches.
> 
> Changes since v5:
> - use a table for compare_opcode() & swap_compare_opcode()
> - fix test cases on 32bit machines

Hmm, I assumed that this series should apply to master, and then
the following 52 patch series on top. However, this series does
not apply on top of master:

  $ git am patches/*
  Applying: don't output value of anonymous symbol's pointer
  Applying: add table to "negate" some opcode
  Applying: use opcode table for compare_opcode()
  error: patch failed: simplify.c:403
  error: simplify.c: patch does not apply
  Patch failed at 0003 use opcode table for compare_opcode()
  The copy of the patch that failed is found in: .git/rebase-apply/patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".
  $ 

Using 'git am -3 patches/*' also doesn't apply.

ATB,
Ramsay Jones


