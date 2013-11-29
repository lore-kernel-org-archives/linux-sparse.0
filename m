From: Christopher Li <sparse@chrisli.org>
Subject: Fwd: [PATCHv2 0/5] sparse: Relicense from non-dfsg-free OSL 1.1 to
 MIT license
Date: Fri, 29 Nov 2013 15:18:23 -0800
Message-ID: <CANeU7QkgPs0FdfCFoMAkB45=CGtBgAFhwUQ3Pp+ydCaRd-FW2Q@mail.gmail.com>
References: <1385633782-775-1-git-send-email-franzschrober@gmail.com>
	<CANeU7Qkjvh4OeCWANFbV6COU4NvjB1pUGXwry7CNCrQz8WG0zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:58809 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab3K2XSX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 29 Nov 2013 18:18:23 -0500
Received: by mail-oa0-f47.google.com with SMTP id k1so11009712oag.34
        for <linux-sparse@vger.kernel.org>; Fri, 29 Nov 2013 15:18:23 -0800 (PST)
In-Reply-To: <CANeU7Qkjvh4OeCWANFbV6COU4NvjB1pUGXwry7CNCrQz8WG0zw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Forget to turn on plain text mode, the previous email get bounce off
vger.

---------- Forwarded message ----------
From: Christopher Li <sparse@chrisli.org>
Date: Fri, Nov 29, 2013 at 3:13 PM
Subject: Re: [PATCHv2 0/5] sparse: Relicense from non-dfsg-free OSL
1.1 to MIT license
To: Franz Schrober <franzschrober@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, jw+debian@jameswestby.net





On Thu, Nov 28, 2013 at 2:16 AM, Franz Schrober <franzschrober@gmail.com> wrote:
>
> Hi,
>
> many different people (especially Dan Carpenter) worked quite hard to contact
> all people with significant contributions. The two changes are the ones which
> should change the license from the problematic OSL[1] to the more liberal MIT
> license. The initial agreement was reached when Novafora (successor in
> interest to Transmeta Corporation) accepted such a license [2]. The commit
> provided by them is attached as "relicense.bundle" [3] and has to be
> unbundled+merged in the sparse repository before the following patches can be
> applied.
>

Thanks for the hard work.

I just apply your 5 patches on top of the merge of the Novofora branch.

I push the result on the chrisl repository. Please check if I did any thing
wrong. I will shortly push it to the official repository and cut a new release.

Chris
