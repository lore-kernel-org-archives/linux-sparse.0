From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] Add the __restrict__ keyword
Date: Thu, 23 May 2013 08:28:56 -0700
Message-ID: <519E35B8.5070300@chrisli.org>
References: <519BC7E0.7030403@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:58303 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759606Ab3EWP3D (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 23 May 2013 11:29:03 -0400
Received: by mail-pd0-f175.google.com with SMTP id 6so2656335pdd.6
        for <linux-sparse@vger.kernel.org>; Thu, 23 May 2013 08:29:01 -0700 (PDT)
In-Reply-To: <519BC7E0.7030403@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 05/21/2013 12:15 PM, Ramsay Jones wrote:
> 
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  ident-list.h          | 2 +-
>  parse.c               | 3 ++-
>  validation/reserved.c | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 


Looks good, will apply.

Chris

