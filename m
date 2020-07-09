Return-Path: <SRS0=LZeG=AU=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2558C433DF
	for <linux-sparse@archiver.kernel.org>; Thu,  9 Jul 2020 15:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C856E20656
	for <linux-sparse@archiver.kernel.org>; Thu,  9 Jul 2020 15:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgGIPuR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:50:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:52154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGIPuR (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Jul 2020 11:50:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E61DAD12
        for <linux-sparse@vger.kernel.org>; Thu,  9 Jul 2020 15:50:16 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
To:     linux-sparse@vger.kernel.org
Subject: using sparse to catch refcount leaks
Date:   Thu, 09 Jul 2020 17:50:11 +0200
Message-ID: <871rlk6630.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

I was thinking the same mechanism for lock checks (lock() has matching
unlock()) could be used for detecting refcount leaks (get() has matching
put()).

This could be used to catch bugs like that:

https://lore.kernel.org/linux-cifs/CAH2r5mtJg0OONLuAYmcggj=M3euDDxRa3Y5-_W1=qxwbeZypqA@mail.gmail.com/T/#mf0e0397aa0b63043d7b3bb0981f0b7323713bfdc

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
