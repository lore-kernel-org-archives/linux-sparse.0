From: Dan Carpenter <error27@gmail.com>
Subject: Re: help for using sparse
Date: Wed, 9 Jun 2010 18:01:31 +0200
Message-ID: <20100609160131.GG5483@bicker>
References: <cd2a19702bb05b6f27255cd697b0ea12@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f223.google.com ([209.85.219.223]:35277 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757921Ab0FIQBm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 Jun 2010 12:01:42 -0400
Received: by ewy23 with SMTP id 23so421246ewy.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 Jun 2010 09:01:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cd2a19702bb05b6f27255cd697b0ea12@ensimag.fr>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: bonneta <bonneta@ensimag.fr>
Cc: linux-sparse@vger.kernel.org

On Wed, Jun 09, 2010 at 05:09:54PM +0200, bonneta wrote:
> I've basically tried "sparse file.c", but it always returns with an error
> like :
> "git-compat-util.h:140:11: error: unable to open 'openssl/ssl.h'"
> or
> "builtin/blame.c:7:10: error: unable to open 'cache.h'"
> 

make CC=~/path/to/sparse/cgcc 

regards,
dan carpenter
