Return-Path: <SRS0=wjqH=DT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA7CC433E7
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Oct 2020 22:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A0520797
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Oct 2020 22:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2J2LiZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgJLWi1 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Oct 2020 18:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgJLWi0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Oct 2020 18:38:26 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDDAC0613D0
        for <linux-sparse@vger.kernel.org>; Mon, 12 Oct 2020 15:38:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u8so25483982ejg.1
        for <linux-sparse@vger.kernel.org>; Mon, 12 Oct 2020 15:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J8PUpUzeACy6LsDZHTcx0gz8UnSzmNpY+/27mXiPJZE=;
        b=L2J2LiZmK9OoVkUQLP0DSvrMdeJx7fd96UHEqfGc8HNtWlDqy+brPghKRWRGI0fvk3
         Zyz/R0RUeibGpLbd7iApeFkz+YvwhQHEIVz9+38errpADErs7RrhX0PvqIE0TkMe8Wdk
         vLUkNPXqkMIQkkchhFVz87lgUWmSi0raWJTVHU4cd2/tQOS6ok9qZZ49YwFC2G8Ys/BR
         cwcEhWc2/CwXG7+BWF6l7eOFkzGHDxf7fV87+smxjU74q4V1gNBXBpL5D7PlpzTb1AA/
         uIVZyakPRbwvCty4ESLdwgXPIOtSkZIRXiU9/u1plWSWXR9X+bx1ilx7WBve79amEwgR
         hxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J8PUpUzeACy6LsDZHTcx0gz8UnSzmNpY+/27mXiPJZE=;
        b=qlIuRTf2pDlmC4ZfTzbJ0l+e3KhcvoUhxbSUDSzsCMGunIzSWkn/GY3q4Zlmqd6ZUA
         OEHTXcjaheWKQkrGNEpmQ2Dl640GgdFwJn34yOGowbOV6mgnkL/q526ZS+DcxEZPvkhH
         JVOg/Zuqcm2HClgQCjhK9QMyFK6HghkuhgukA4IVPvbhYp8xNVwb+X8WXi7NToVnt+3c
         g+rwjaisK/yMK5NjSSjxgdkgA+lGb9JFr+xmtdpkgw5pXSxHFsHyn8baipP8AP/cR5/L
         9XiOD9b3+4wAHt5AlFawPXV3VMBcEXQdrBYZtYVJi8ZnU1JjdphmQ3tQtycwA97blAJe
         RmZQ==
X-Gm-Message-State: AOAM532VGSvWOohbbqsDh/7uGd0Qm+yRzienmOmklakycRsoiniEAXSV
        QKLyI2SOBCfz7DkCG1wax8I=
X-Google-Smtp-Source: ABdhPJwZgLYZRD+PhM6Eo80FjtxLmXKXFqGfqKfEnEwLs7H4oOsUo09qquzThy85pfRKibMH2Oe2kg==
X-Received: by 2002:a17:906:4e19:: with SMTP id z25mr31312101eju.44.1602542303818;
        Mon, 12 Oct 2020 15:38:23 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:68a0:d8d7:26ec:2090])
        by smtp.gmail.com with ESMTPSA id sd18sm11085330ejb.24.2020.10.12.15.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 15:38:22 -0700 (PDT)
Date:   Tue, 13 Oct 2020 00:38:21 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 0/8] format check tweaks
Message-ID: <20201012223821.i7fymzwxqwstx75r@ltop.local>
References: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
 <58d771f9-7560-f682-3173-78dea0f83711@codethink.co.uk>
 <20201005234749.dfw34pvgb2uavuko@ltop.local>
 <504d8f5f-d8bc-e7f5-a096-ee097411c3f9@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504d8f5f-d8bc-e7f5-a096-ee097411c3f9@codethink.co.uk>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Oct 11, 2020 at 08:51:59PM +0100, Ben Dooks wrote:
> 
> I've not had time to run the latest against the kernel as I forgot
> the disc password to my main machine and have had to rebuild the
> system from scratch.

Definitively not fun :(
 
> Let me know if there's anything else I can help with.

Better wait till I've something more or less complete, probably tomorrow.

-- Luc
