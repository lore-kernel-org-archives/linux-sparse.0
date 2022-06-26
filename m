Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1835BC433EF
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 16:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiFZQEb (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 12:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZQEb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 12:04:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AE365C7
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 09:04:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so2025579edb.9
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lANZhHaiWFdOJ6kHHmTcq1oYjRjKFk0l6nP6jXuo0IA=;
        b=KoKrZC3wZshIC9plIHo09ude/izbhitZhFGKW2PgfEJl0s1UODtLZWvcAzn+LhVYfh
         D4ZokC3ZSKDmlWseQLv1XTlAijNoUNiDrDOVeFRa6Cb/QST9IWUeMkPBNc4R2xtlOS28
         q/U3qhjzf8FoQGh39+4c5q29nmgvlgDfs6lCH+x/2f7ViVBLhRaU6Nw8Z7ORexA+mU1i
         qwiXjuSmKKOVLjzTzfdrdEXsyVg9BMTKNzEBt2XuKMubXZ/hmlHF356uVg+0GreKNdcq
         SVjv+cj2v9WOJim7006Ya0c4jMVyhHUkwznRyqxhCkzA/wMLZi/AWohWrDYJhZn8gX6a
         K+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lANZhHaiWFdOJ6kHHmTcq1oYjRjKFk0l6nP6jXuo0IA=;
        b=cESwibaHJUHbryU/oc/OKh6ZEfryD8Gjbs96D4TDnT+gctf8tefNFm+f5Zv/mC2KH7
         3td2Q9cn5DE1rBseLu5h7ITDIHke6KpZw96/r0KyImmAPVMkxSyNV/b1IUnpibbxGMzg
         OmWS0ccEUycJxxNNUZnn+7BUpazsZTwVKaIQWm+HOPF4KLDIiK6LoX/hizx6Hto7gODl
         5qasu/SSAFxou+lOj3yiOQ9upTw9OskkDS2C/aVws6uE5pXkGmrYf5wKfGz3LDlnUe/K
         BwYvOA1GFzlhjtwiZGXblvVT7o9TbPyyH9QcHKaEHlMbmVNNhcEFTno7qlDCbz7zUtSh
         Ut5g==
X-Gm-Message-State: AJIora+e5CqYY/UR9fBbqIZd5S2roTsVkP1lqkCNvnSKMFxFXx5/poK9
        QbBc5u7gi85onCD/TwFDdMm/8IJfxHY=
X-Google-Smtp-Source: AGRyM1s/uG7ebdEIZM66sfU+Ktn9OEXlXK738h6VjC9IiZmIq+gbWRFTM017SAj2lx5trkl9x6/bZg==
X-Received: by 2002:a05:6402:909:b0:435:a8b:5232 with SMTP id g9-20020a056402090900b004350a8b5232mr11478384edz.240.1656259468443;
        Sun, 26 Jun 2022 09:04:28 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id r23-20020a170906705700b006fec56c57e6sm3941493ejj.46.2022.06.26.09.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 09:04:28 -0700 (PDT)
Date:   Sun, 26 Jun 2022 18:04:26 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Luc Van Oostenryck <lucvoo@kernel.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] inline: avoid node of node on variadics
Message-ID: <20220626160426.ejoestj6gqrwwofs@mail>
References: <20220625221454.63271-1-lucvoo@kernel.org>
 <2491612b-afa2-5e81-05d7-73bfd6aaa26c@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2491612b-afa2-5e81-05d7-73bfd6aaa26c@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Jun 26, 2022 at 03:38:22PM +0100, Ramsay Jones wrote:
> Hi Luc,

Hi!
 
> I was just about to comment on this patch when I noticed [PATCH 2/6] of
> a new series, which, if I'm reading it correctly replaces this patch; yes?

Yes, indeed. I should have mentioned that but ... :)
 
> [I have been a little tardy recently, but I do try to read all patches! ;) ]

No problems. It's why I generally wait a few days before pushing patches
to the main tree.


Cheers,
-- Luc
