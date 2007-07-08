From: Pavel Roskin <proski@gnu.org>
Subject: Re: Structures from -include are "weak"
Date: Sun, 08 Jul 2007 02:25:23 -0400
Message-ID: <1183875923.13053.2.camel@gx>
References: <1183865570.12651.18.camel@gx>
	 <20070708054218.GD21668@ftp.linux.org.uk>
	 <20070708060609.GE21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:10708 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404AbXGHGZ0 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 8 Jul 2007 02:25:26 -0400
In-Reply-To: <20070708060609.GE21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Sun, 2007-07-08 at 07:06 +0100, Al Viro wrote:
> Gyah...  So it is.  We put the stuff from -include into builtin_scope
> and start the file scope only in __sparse().
> 
> See if adding
...
> in parse.c:struct_union_enum_specifier() would fix all problems of that kind.

Yes, it's working like a charm!  Tested on 3 projects: madwifi, at76_usb
and orinoco_usb - all are fine.  Thank you!

-- 
Regards,
Pavel Roskin
