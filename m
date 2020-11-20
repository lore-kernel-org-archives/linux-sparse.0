Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE04C2D0E4
	for <linux-sparse@archiver.kernel.org>; Fri, 20 Nov 2020 18:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C375822464
	for <linux-sparse@archiver.kernel.org>; Fri, 20 Nov 2020 18:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xgp53yTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbgKTSnr (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731207AbgKTSnr (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 20 Nov 2020 13:43:47 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A67A2245F;
        Fri, 20 Nov 2020 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897826;
        bh=BYh1+J/eqOcYaGUTamspD4Ta2L9FWc3B70Cfr13Zxko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xgp53yTpNWrQHKiJlW5n8wWSZMlA6iHzcNVDQb2t0PlV0T/XnwQhl6+U179YkmXdI
         2NS3gNuTlYbK435auBPJE2tKS72SqajALI3oVG+//j/6aP9/ucHAy0ZNFaMvdi9XJc
         yVoKn60B8Jysg6R5D9JPvznUYU9Bcf+N9yU44dcc=
Date:   Fri, 20 Nov 2020 10:43:45 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: add annotation for
 sock_{lock,unlock}_fast
Message-ID: <20201120104345.56b68991@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <6ed7ae627d8271fb7f20e0a9c6750fbba1ac2635.1605634911.git.pabeni@redhat.com>
References: <6ed7ae627d8271fb7f20e0a9c6750fbba1ac2635.1605634911.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, 17 Nov 2020 19:43:49 +0100 Paolo Abeni wrote:
> The static checker is fooled by the non-static locking scheme
> implemented by the mentioned helpers.
> Let's make its life easier adding some unconditional annotation
> so that the helpers are now interpreted as a plain spinlock from
> sparse.
> 
> v1 -> v2:
>  - add __releases() annotation to unlock_sock_fast()
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Applied, thank you!
