From: Christopher Li <sparse@chrisli.org>
Subject: Re: help for using sparse
Date: Wed, 9 Jun 2010 09:00:38 -0700
Message-ID: <AANLkTim1Gr-k3BZ-hsdPdZQ8j1QPCEeWycwFGdqKwbxj@mail.gmail.com>
References: <cd2a19702bb05b6f27255cd697b0ea12@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60436 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab0FIQAj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 Jun 2010 12:00:39 -0400
Received: by gwj15 with SMTP id 15so162759gwj.19
        for <linux-sparse@vger.kernel.org>; Wed, 09 Jun 2010 09:00:38 -0700 (PDT)
In-Reply-To: <cd2a19702bb05b6f27255cd697b0ea12@ensimag.fr>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: bonneta <bonneta@ensimag.fr>
Cc: linux-sparse@vger.kernel.org

On Wed, Jun 9, 2010 at 8:09 AM, bonneta <bonneta@ensimag.fr> wrote:
> I've basically tried "sparse file.c", but it always returns with an error
> like :
> "git-compat-util.h:140:11: error: unable to open 'openssl/ssl.h'"
> or
> "builtin/blame.c:7:10: error: unable to open 'cache.h'"
>
> I don't know how to resolve it...

You need to tell sparse where is your openssl/ssl.h.

BTW, can you compile file.c using git's make system?
You can try to copy the file searching path to sparse.

Another thing to try is using the cgcc. Cgcc is a wrapper
script that try to behave like gcc + sparse check.

Chris
