From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Mon, 21 Nov 2016 10:45:51 +0100
Message-ID: <1479721551.8662.10.camel@sipsolutions.net>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
         <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
         (sfid-20161121_033848_063837_43B872B5)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:33338 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752580AbcKUJp6 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Nov 2016 04:45:58 -0500
In-Reply-To: <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com> (sfid-20161121_033848_063837_43B872B5)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>


> There is other possible __builtin_xxx() function gcc expected to get
> a const result when the input arguments are constant.  Ideally, we
> should be able to mark __builtin_bswap16 as a special constant "pass
> through" function. So during the evaluation and constant propagation,
> sparse can pass through the native __builtin_xxx() call to get the
> const result. In other words, sparse shouldn't need to implement
> "__builtin_bswap16()" by itself. It can just call to the gcc
> one to get the result. Then we can treat all other similar
> __builtin_xxx function the same way.

Yes, that'd make some sense. I have no idea how to pull it off though
:)

johannes
