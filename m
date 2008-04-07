From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: rewrite_parent_branch: Assertion `changed' failed
Date: Mon, 07 Apr 2008 23:29:31 +0200
Message-ID: <47FA923B.1080109@gmail.com>
References: <47FA6DAF.3030600@gmail.com>  <47FA708D.5080203@gmail.com> <1207603339.22430.48.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:64498 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757284AbYDGV3f (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Apr 2008 17:29:35 -0400
Received: by nf-out-0910.google.com with SMTP id g13so772559nfb.21
        for <linux-sparse@vger.kernel.org>; Mon, 07 Apr 2008 14:29:34 -0700 (PDT)
In-Reply-To: <1207603339.22430.48.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On 04/07/2008 11:22 PM, Pavel Roskin wrote:
> On Mon, 2008-04-07 at 21:05 +0200, Jiri Slaby wrote:
>> It's 2.6.25-rc8-mm1 code. It's opensuse sparse-0.1-46, core from the
>> crash is here:
>> http://www.fi.muni.cz/~xslaby/sklad/core.sparse.bz2
> 
> If it's indeed version 0.1, I strongly suggest that you test the current
> git version, which is version 0.4.1 plus 10 or so patches.

Heh, what the hell, how old is it? A year and a half. I must admit I haven't 
noticed the version in the haste... Filing a bug, thanks.
