From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: buffer overflow check bug
Date: Mon, 18 Jun 2012 22:53:44 +0300
Message-ID: <20120618195344.GM4400@mwanda>
References: <4FDBA56F.8070106@gmail.com>
 <4FDEFCB1.7030800@gmail.com>
 <4FDF0AA5.6080905@gmail.com>
 <20120618113037.GI4400@mwanda>
 <4FDF1610.3000100@gmail.com>
 <20120618121726.GG13539@mwanda>
 <4FDF2036.4080908@gmail.com>
 <20120618134338.GJ4400@mwanda>
 <20120618181111.GH13539@mwanda>
 <CAHGf_=rNSUKPrV5yYyJ8KWbvHO4zAPU7Du4_9HbwW-HiLVbFiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:33821 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab2FRTxy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2012 15:53:54 -0400
Content-Disposition: inline
In-Reply-To: <CAHGf_=rNSUKPrV5yYyJ8KWbvHO4zAPU7Du4_9HbwW-HiLVbFiw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Cc: smatch@vger.kernel.org, linux-sparse@vger.kernel.org

Gar...  I have no idea.  That seems like an issue in sparse.

Does anyone know why MOD_NORETURN gets set for:
extern void my_exit(const char*, ...) __attribute__ ((__noreturn__));

but not for:
extern __attribute__ ((__noreturn__)) void my_exit(const char*, ...);

GCC seems to accept both formats.

regards,
dan carpenter

