From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/3] Warn about initialization of a char array with a too
 long constant C string.
Date: Mon, 22 Apr 2013 09:42:12 -0700
Message-ID: <CANeU7Qmg15kHmR3_x20yBEa6dPGmYK7xms+vZzWzdRTjcB+OSw@mail.gmail.com>
References: <1365267537-3787-1-git-send-email-yamato@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:54134 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab3DVQmN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Apr 2013 12:42:13 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so4410933oah.21
        for <linux-sparse@vger.kernel.org>; Mon, 22 Apr 2013 09:42:12 -0700 (PDT)
In-Reply-To: <1365267537-3787-1-git-send-email-yamato@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Masatake YAMATO <yamato@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Apr 6, 2013 at 9:58 AM, Masatake YAMATO <yamato@redhat.com> wrote:
> This patch adds new option -Winit-cstring to sparse.
>
> With the option sparse can Warn about initialization of a char array
> with a too long constant C string.  If the size of the char array and
> the length of the string is the same, there is no space for the last
> nul char of the string in the array.

Patches applied.

Chris
