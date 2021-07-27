Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA73C4338F
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Jul 2021 12:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCB760234
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Jul 2021 12:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhG0Ms2 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 27 Jul 2021 08:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhG0Ms2 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 27 Jul 2021 08:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C80F760234;
        Tue, 27 Jul 2021 12:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627390108;
        bh=AKhOwNaaknHgi1m8tCPeZY3QhCjtchuAkFhhqFgE9ig=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tyYcQG2EvzCGjPe2MLcROOIL/WciReNu0/TEDDiTAgE2/TkZuY/3i5Tr4cV3JGZzj
         Rdqsjy6TWKXkslAmyno2itllKMFnEs4RIiQLZCuRdZ9HIyIV9KdAU2BT5Jeaaca9Ps
         acopnwfzWRYgC4MlJFnLFWsNkovh4DHZRX5vt9wmgs3nPUHmxb0sCfiLxbSOuOhqCB
         CP8TxtXFshaAW4ZM9XDkxFW+eokaCjD38U0AzOLNIUFC6kUGMDnNIUDl5/wN2opb0V
         1uHXiwcDUsy2Z26XZCPokQsNDWNRuTJ2ke2Su8A8sSnXb3fd8uZE9bb/n87q8uMqAM
         wzjgvBdrh91AQ==
Message-ID: <330ba271fdc21d5453702d4403be6f35b5e9dd76.camel@kernel.org>
Subject: Re: new sparse release?
From:   Jeff Layton <jlayton@kernel.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck.ml@gmail.com>
Date:   Tue, 27 Jul 2021 08:48:26 -0400
In-Reply-To: <20210726155045.fo6nh4lryln5sgxl@mail>
References: <c7963e9e4c7d5b91fc8bee9c9ae9a9c893664e0b.camel@kernel.org>
         <20210726155045.fo6nh4lryln5sgxl@mail>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, 2021-07-26 at 17:50 +0200, Luc Van Oostenryck wrote:
> On Mon, Jul 26, 2021 at 07:20:28AM -0400, Jeff Layton wrote:
> > It's been quite a while since we've had a new sparse release and there
> > are some fixes that I'd like to see in the fedora package. I could just
> > cut a release from a current git snapshot, but I don't want to do that
> > if there are any plans to do a release soon. 
> > 
> > Any idea when the next sparse release will be?
> 
> I've been quite a bit side-tracked lately and as such I had nothing
> really planned. But yes, it's been a while with enough changes already.
> I've a few minor fixes I would like to add and a bigger series (but
> one 'm not really happy with). I'll see what I can do n the next days
> but the idea would be to do a -rc next WE and the full release a few
> days later (so around Aug 5) if nothing serious come up.
> 
> Would this be OK for you?
> 

Yeah, sounds fine. No huge rush for any of this, to be clear, but it
would be nice to have an updated release in the near future.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

