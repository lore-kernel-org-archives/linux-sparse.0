Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951CDC433FE
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Dec 2020 22:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E5D222F9
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Dec 2020 22:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLEWdc (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Dec 2020 17:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgLEWdc (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Dec 2020 17:33:32 -0500
Date:   Sat, 5 Dec 2020 14:32:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607207572;
        bh=YZrn1IlbhlQAWy/qDP82GR67nZ5d803g393MCcPsdm0=;
        h=From:To:Cc:Subject:From;
        b=twsk11/9zewfQGMp7lYWqYVhZoy4/KRwjuLf0RSixLZfecN1zel/wVGotAM9CmPey
         Gk/tTHNkAqEHZMWXL0te3VsBLAs8puHlskNXm0oz5cZAB3gh1D50OSOO7qWAZf3G8C
         y2b2rA6Imfu+XJsHgwn1pv1par5Vgbx9FVjdQyBUAn3Urxayg252b6BIGETxX0CKX8
         PbnvDiP8xtN1KcZ1JFInrWoqiZWgIO0tcEw3b2eXxBCSDIc4QTAwF8i/pUITV1ZiCQ
         6sQtKmZ8LaD/QkqtiB/0HWMg4HPdf9pSpZ4uS7Da5trS1WlJ9LUKk/Os2rNZIXRpp/
         MWmSzdVfgy1yg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, edwin.peer@broadcom.com,
        Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: sparse annotation for error types?
Message-ID: <20201205143250.2378b9f9@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi!

Recently we've been getting a steady stream of patches from Changzhong
to fix missing assignment to error variables before jumping to error
cases.

I wonder if for new code it'd make sense to add an annotation for a type
which has to be returned non-zero?

What I have in mind is the following common flow:

int do_a_thing(struct my_obj *obj, int param)
{
	int err;

	err = first_step(obj, 1);
	if (err)
		return err;

	if (some_check(obj)) {
		err = -EINVAL; /* need explicit error set! */
		goto err_undo_1s;
	}

	err = second_step(obj, param);
	if (err)
		goto err_undo_1s;

	err = third_step(obj, 0);
	if (err)
		goto err_undo_2s;

	return 0;

err_undo_2s:
	second_undo(obj);
err_undo_1s:
	first_undo(obj);
	return err;
}


The variable err should never be returned when it's equal to 0.
So if we annotate it, let's say as:

	int __nzret err;

could sparse then warn if we forgot to assign it after
"if (some_check(obj))"? 

Am I the only one who thinks this would be a good idea?
