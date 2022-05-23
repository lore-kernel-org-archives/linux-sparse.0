Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54DEC433EF
	for <linux-sparse@archiver.kernel.org>; Mon, 23 May 2022 07:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiEWH2w (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 23 May 2022 03:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiEWH1u (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 23 May 2022 03:27:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB29C261B
        for <linux-sparse@vger.kernel.org>; Mon, 23 May 2022 00:25:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 31C61219B8;
        Mon, 23 May 2022 06:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653288540;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mKe0KDI1XuBtthip5H07kpnw2ZwXio91un4+Sq6aE8Y=;
        b=Yp+EABQaRvn9GFY4sFO5OFZfBeeRW+yqiiWbd0ufOeKcXSAbdB7Pi6W9A4oh5WlHqp9yCk
        LYtcsjJwWSdkbu2oAUTC6TLn/a91Rof3UmD83z3NJB30Vsr0WuWoqVisYz4gqfcYlwUurA
        UFSmZnBo5Q6RHHFH66RKm8x5lZml8T4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653288540;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mKe0KDI1XuBtthip5H07kpnw2ZwXio91un4+Sq6aE8Y=;
        b=rIzQv5YS0mCHQXk0qMFZFXtF8ik7WFPyMiTX64bw+gpsLYj7wjdy9CCzn/WlXcQIUow7JK
        Va3Jenncj4hu20Bg==
Received: from g78 (unknown [10.163.24.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CBAD22C141;
        Mon, 23 May 2022 06:48:58 +0000 (UTC)
References: <87k0ggbjb0.fsf@suse.de> <20220522122227.mcgnatle6zmgqycn@mail>
User-agent: mu4e 1.6.10; emacs 28.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org, pvorel@suze.cz, chrubis@suse.cz,
        io@richiejp.com
Subject: Re: Linux Test Project vendored Sparse
Date:   Mon, 23 May 2022 07:45:00 +0100
Reply-To: rpalethorpe@suse.de
In-reply-to: <20220522122227.mcgnatle6zmgqycn@mail>
Message-ID: <87y1ys3fsa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hello Luc,

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> On Tue, Dec 07, 2021 at 01:33:56PM +0000, Richard Palethorpe wrote:
>> Hello Sparse contributors,
>
> Hi,
>
> Please accept my apologies for replying so lately.
>  
>> After trying a number of static analysis tools we settled on Sparse to
>> roll our own C checks.
>
> Nice!
>
>> We use a mixture of the linearized form and AST. If you are interested
>> please see:
>> https://github.com/linux-test-project/ltp/blob/master/tools/sparse/
>> Also I will attach the main code to the body of this e-mail it is only
>> 283 lines.
>> 
>> I still don't have a firm grasp on how Sparse works, so any feedback
>> would be welcome. BTW we include Sparse as a git module and so far there
>> have been no complaints.
>
> I've taken a good look at it and everything look good.
> I also think that using Sparse as a git module is the good choice.
>
> If you have any question, do not hesitate to ask (I should be much
> more responsive now).
>  
> Best regards,
> -- Luc

That's good to see and thanks for merging my patch!

-- 
Thank you,
Richard.
