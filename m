From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] remove unused field 'multijump' in struct instruction
Date: Mon, 6 Feb 2017 21:35:12 +0100
Message-ID: <20170206203511.ucii2awpjwcmw5p5@macpro.local>
References: <20161122164330.3953-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36776 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdBFUfP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Feb 2017 15:35:15 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so24218969wmd.3
        for <linux-sparse@vger.kernel.org>; Mon, 06 Feb 2017 12:35:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161122164330.3953-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

On Tue, Nov 22, 2016 at 05:43:30PM +0100, Luc Van Oostenryck wrote:
> This field was introduced (I think) for OP_SWITCH but is
> not needed anymore as OP_SWITCH has its own entry with a field
> fOr multijump list.
> ---
>  linearize.h | 3 ---
>  1 file changed, 3 deletions(-)
> 

Here is my s-o-b I had forgot to add:
    Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
