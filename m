From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: enum warning patch (was Re: Defect in linearization of short circuit &&)
Date: Tue, 16 Feb 2010 21:18:28 +0100
Message-ID: <201002162118.28516.kdudka@redhat.com>
References: <4B77FD0F.50401@googlemail.com> <70318cbf1002161136o56cd0494pc6a2e38e28f1729c@mail.gmail.com> <201002162111.31449.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24908 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756823Ab0BPUTh (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Feb 2010 15:19:37 -0500
In-Reply-To: <201002162111.31449.kdudka@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Tuesday 16 of February 2010 21:11:31 Kamil Dudka wrote:
> It makes no sense to me - on my box I am getting the same
> sizeof(struct expression)==64 before/after the patch applied.

I've just remembered.  There was problem on a 32bit system - 32 bytes before 
and 36 bytes after the patch applied...

Kamil
