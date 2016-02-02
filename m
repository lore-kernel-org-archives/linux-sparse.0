From: Bob Copeland <me@bobcopeland.com>
Subject: Re: error: ctype on uninitialized symbol
Date: Mon, 1 Feb 2016 21:53:27 -0500
Message-ID: <20160202025327.GF24581@localhost>
References: <20160201194409.GA15047@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33660 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcBBCxa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 1 Feb 2016 21:53:30 -0500
Received: by mail-qg0-f48.google.com with SMTP id b35so137301280qge.0
        for <linux-sparse@vger.kernel.org>; Mon, 01 Feb 2016 18:53:30 -0800 (PST)
Received: from hash ([2001:470:1d:6db:230:48ff:fe9d:9c89])
        by smtp.gmail.com with ESMTPSA id r76sm7510175qkl.32.2016.02.01.18.53.29
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2016 18:53:29 -0800 (PST)
Received: from bob by hash with local (Exim 4.84)
	(envelope-from <me@bobcopeland.com>)
	id 1aQR5r-0002tH-6b
	for linux-sparse@vger.kernel.org; Mon, 01 Feb 2016 21:53:27 -0500
Content-Disposition: inline
In-Reply-To: <20160201194409.GA15047@localhost>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Mon, Feb 01, 2016 at 02:44:09PM -0500, Bob Copeland wrote:
> Hi all,
> 
> I'm seeing the following error when running sparse with latest HEAD,
> against the small test case at the end:
> 
> $ sparse sparse-test.c
> [garbage]:0:0: error: ctype on uninitialized symbol 0x696ec0

Nevermind, I fooled myself.  Turns out this "sparse" was an old version
of smatch, not the freshly-built sparse that "sparse --version" was
reporting.

It looks like this bug was fixed around 0.4.4.

Sorry for the noise!

-- 
Bob Copeland %% http://bobcopeland.com/
