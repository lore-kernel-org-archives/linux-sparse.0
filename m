From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 3/5] IR: remove never-generated instructions
Date: Wed, 14 Feb 2018 05:08:06 +0000
Message-ID: <CACXZuxc7dFwDPq56das5Q1p6hA9qW=C3QdppRf0cjHeeQcsnUg@mail.gmail.com>
References: <20180214010843.23651-1-luc.vanoostenryck@gmail.com> <20180214010843.23651-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:46933 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeBNFIH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Feb 2018 00:08:07 -0500
Received: by mail-vk0-f41.google.com with SMTP id o204so296724vkd.13
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 21:08:07 -0800 (PST)
In-Reply-To: <20180214010843.23651-4-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 14 February 2018 at 01:08, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Some of the IR instructions have been defined but are
> never generated.
>
> -### Unused ops
> -#### OP_VANEXT
> -#### OP_VAARG
> -#### OP_MALLOC
> -#### OP_FREE
> -#### OP_ALLOCA
> -#### OP_GET_ELEMENT_PTR
> -#### OP_INVOKE
> -#### OP_UNWIND

Hi Luc, I would argue for not removing some of these instructions.

The VA instructions are definitely needed as today Sparse backend code
generators cannot handle var args because no instructions are
generated.
Similarly alloca should perhaps be emitted to indicate stack
allocations - this would make the stack usage explicit.

Thanks and Regards
Dibyendu
