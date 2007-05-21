From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH] __DATE__ & __TIME expansion
Date: Mon, 21 May 2007 01:06:56 +0100
Message-ID: <4650E2A0.2040000@knosof.co.uk>
References: <11796983862564-git-send-email-damien.lespiau@gmail.com>	 <11796983861111-git-send-email-damien.lespiau@gmail.com>	 <20070520225019.GA2547@daikokuya.co.uk>	 <4650D368.1060806@freedesktop.org> <cbf3148c0705201649q46627dk228e8c0f427d5879@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from queueout03-winn.ispmail.ntl.com ([81.103.221.33]:46057 "EHLO
	queueout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758304AbXEUAQI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 May 2007 20:16:08 -0400
In-Reply-To: <cbf3148c0705201649q46627dk228e8c0f427d5879@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: Josh Triplett <josh@freedesktop.org>, Neil Booth <neil@daikokuya.co.uk>, linux-sparse@vger.kernel.org

Damien,

>> > It seems your code could lead to these macros having different
>> > values in a long compilation, which the standard doesn't permit.
> 
> Ouch, I didn't know that either. I learned to be humble before C. Still, 
> I had
> a quick look at the C99 standard and couldn't find it explicitly. No wonder
> why I didn't know it in the first place.

Sentence 2004: http://c0x.coding-guidelines.com/6.10.8.html

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
