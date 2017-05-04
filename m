From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4] sparse: add support for _Static_assert
Date: Thu, 4 May 2017 16:58:35 +0200
Message-ID: <20170504145834.mef3psritw2lxf35@ltop.local>
References: <20170503165518.7625-1-lrichard@redhat.com>
 <20170503235403.6i5za2wa526fmp6w@desk.local>
 <CAMHZB6Gjf5gX92yiGshRgCpCLM=xuxBkXyDQ=RQA=gx6bG3PpQ@mail.gmail.com>
 <1089027793.4868687.1493906030607.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36703 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdEDO6j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 10:58:39 -0400
Received: by mail-wm0-f53.google.com with SMTP id u65so21380700wmu.1
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2017 07:58:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1089027793.4868687.1493906030607.JavaMail.zimbra@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 04, 2017 at 09:53:50AM -0400, Lance Richardson wrote:
> Thanks for the quick feedback, will incorporate in v5. 

I also saw a small issue, possibly related to the problem with
the mixup between 'declaration-list' and 'struct-declarator-list'
that you noticed. In the following code, the static assert is not
recognized:
	void foo(void)
	{
		int i = 0;
		for (_Static_assert(1, "ok"); 1; )
			;
		for (_Static_assert(0, "ko"); 1; )
			;
	}

It should because (since C99) the first part of the for-statement
is just a 'declaration', which include the static assert.
Not that it's very important, though.

Probably, it's best to leave it as is for the moment and just
add a new test case, annotated with 'check-known-to-fail'.

-- Luc
