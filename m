From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: Signed divides vs shifts (Re: [Security] /dev/urandom uses uninit bytes, leaks user data)
Date: Mon, 17 Dec 2007 10:05:35 -0800
Message-ID: <2c0942db0712171005w65bbb512p71a4f9b1fc65c6a7@mail.gmail.com>
References: <E1J3RD5-0006yU-00@gondolin.me.apana.org.au>
	 <alpine.LFD.0.9999.0712170856050.21557@woody.linux-foundation.org>
	 <20071217185557.0b501e23.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:13655 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbXLQSFh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 17 Dec 2007 13:05:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1601717ugc.16
        for <linux-sparse@vger.kernel.org>; Mon, 17 Dec 2007 10:05:36 -0800 (PST)
In-Reply-To: <20071217185557.0b501e23.dada1@cosmosbay.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, John Reiser <jreiser@bitwagon.com>, Andrew Morton <akpm@linux-foundation.org>, security@kernel.org, tytso@mit.edu, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mpm@selenic.com, linux-sparse@vger.kernel.org

On Dec 17, 2007 9:55 AM, Eric Dumazet <dada1@cosmosbay.com> wrote:
> -               mid = (last - first) / 2 + first;
> +       while (low <= high) {
> +               mid = (low + high) / 2;

I think you just introduced a bug. Think about what happens if
low=high=MAX_LONG/2 + 1.
