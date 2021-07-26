Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE49BC4338F
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Jul 2021 11:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE4560BD3
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Jul 2021 11:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhGZKkB (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 26 Jul 2021 06:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233143AbhGZKkA (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Jul 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4679660F11;
        Mon, 26 Jul 2021 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627298429;
        bh=nTmBgNP+9mpJEVQU4n4HDNF92pw5WHHfTs173umsPXs=;
        h=Subject:From:To:Cc:Date:From;
        b=a3hBMDxEAZK+OUZmm7Lk+waYSh3Hb7AGcO+uxYmqlrnkItEqDG2Li+jwoKODgaQvC
         uT7V9LeEN7b9qvX/wz+RUa1utNYyxIU4wNEa0iLjt/L13cz6LlMm8Or0GxCbFVH/NK
         4Vhx0vO8dT5E+9TUfY0UCWleCeV03EIDFo3oKL0T1JUilZMHtS9riVH/kFsR2o1s7E
         mVC8HGbf/xiz0MOE9jbzyuCAp7gXH5bDU/m+4mH1Le+qOy1e5keLNmPh9hWM969HAi
         ChpqLxcwtKsP3tjvzTlV5K7gB6Lac8oZZ0JfvtIRJj3RywrBXDXwozqMpoYb862Da/
         vOw+xTJkKuMtw==
Message-ID: <c7963e9e4c7d5b91fc8bee9c9ae9a9c893664e0b.camel@kernel.org>
Subject: new sparse release?
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck.ml@gmail.com>
Date:   Mon, 26 Jul 2021 07:20:28 -0400
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

It's been quite a while since we've had a new sparse release and there
are some fixes that I'd like to see in the fedora package. I could just
cut a release from a current git snapshot, but I don't want to do that
if there are any plans to do a release soon. 

Any idea when the next sparse release will be?

Thanks, 
-- 
Jeff Layton <jlayton@kernel.org>

