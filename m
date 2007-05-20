From: "Damien Lespiau" <damien.lespiau@gmail.com>
Subject: Re: [PATCH] __DATE__ & __TIME expansion
Date: Mon, 21 May 2007 01:49:24 +0200
Message-ID: <cbf3148c0705201649q46627dk228e8c0f427d5879@mail.gmail.com>
References: <11796983862564-git-send-email-damien.lespiau@gmail.com>
	 <11796983861111-git-send-email-damien.lespiau@gmail.com>
	 <20070520225019.GA2547@daikokuya.co.uk>
	 <4650D368.1060806@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:64030 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758179AbXETXtZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 May 2007 19:49:25 -0400
Received: by wx-out-0506.google.com with SMTP id i26so125782wxd
        for <linux-sparse@vger.kernel.org>; Sun, 20 May 2007 16:49:24 -0700 (PDT)
In-Reply-To: <4650D368.1060806@freedesktop.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Neil Booth <neil@daikokuya.co.uk>, linux-sparse@vger.kernel.org

> Neil Booth wrote:
> > It seems your code could lead to these macros having different
> > values in a long compilation, which the standard doesn't permit.

Ouch, I didn't know that either. I learned to be humble before C. Still, I had
a quick look at the C99 standard and couldn't find it explicitly. No wonder
why I didn't know it in the first place.

On 5/21/07, Josh Triplett <josh@freedesktop.org> wrote:
> I feel better about asking for a fix to only call time once, now. :)

Don't be afraid to hurt my feelings, I still have a lot to learn and I know it
well :p

-- 
Damien Lespiau
