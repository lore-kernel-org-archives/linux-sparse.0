From: Kamil Dudka <kdudka@redhat.com>
Subject: enum warning patch (was Re: Defect in linearization of short circuit &&)
Date: Tue, 16 Feb 2010 21:11:31 +0100
Message-ID: <201002162111.31449.kdudka@redhat.com>
References: <4B77FD0F.50401@googlemail.com> <4B7AEFDF.3000608@googlemail.com> <70318cbf1002161136o56cd0494pc6a2e38e28f1729c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57207 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932757Ab0BPUMk (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Feb 2010 15:12:40 -0500
In-Reply-To: <70318cbf1002161136o56cd0494pc6a2e38e28f1729c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Tuesday 16 of February 2010 20:36:21 Christopher Li wrote:
> I am still sitting on the enum warning patch. That is the only thing
> holding up another minor release.

Still trying to save a sizeof(void *) within struct expression?

It makes no sense to me - on my box I am getting the same
sizeof(struct expression)==64 before/after the patch applied.

Kamil
