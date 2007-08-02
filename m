From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: specifying custom attributes
Date: Thu, 2 Aug 2007 18:53:41 -0400
Message-ID: <8bd0f97a0708021553m6edaefccof086012f64b199a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:3737 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349AbXHBWxn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Aug 2007 18:53:43 -0400
Received: by an-out-0708.google.com with SMTP id d31so128123and
        for <linux-sparse@vger.kernel.org>; Thu, 02 Aug 2007 15:53:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Robin Getz <rgetz@blackfin.uclinux.org>

the Blackfin port has a few custom gcc attributes that annoys sparse:
include/asm/uaccess.h:63:77: error: attribute 'l1_text': unknown attribute

is there a way from the cmdline to specify a custom list of OK
attributes ?  i feel like adding these processor-specific attributes
to the source code may not be the way you guys wish to go ...
-mike
