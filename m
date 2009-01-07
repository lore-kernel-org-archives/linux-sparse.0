From: mosfet <forumer@smartmobili.com>
Subject: source code transform
Date: Wed, 07 Jan 2009 19:48:09 +0100
Message-ID: <a15fe1ffe7f7a6faf8f79d4ac780b663@mail.smartmobili.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sd-15251.dedibox.fr ([88.191.74.51]:35920 "EHLO
	mail.smartmobili.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439AbZAGSyn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Jan 2009 13:54:43 -0500
Received: from www.smartmobili.com (unknown [88.191.74.51])
	by mail.smartmobili.com (Postfix) with ESMTP id 9560414014
	for <linux-sparse@vger.kernel.org>; Wed,  7 Jan 2009 19:48:09 +0100 (CET)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I would like to know if sparse would be able to parse GCC source file to
add a comment in each function it encounters ?
For instance let's say I want to trace every function in c-parser.c :


static struct c_typespec
c_parser_enum_specifier (c_parser *parser)
{
...

}

in a first step I would like to modify source code like this :

static struct c_typespec
c_parser_enum_specifier (c_parser *parser)
{
 fprintf(stderr, "c-parser.c: c_parser_enum_specifier()\n");
...

}

is it possible with sparse ?



-- 
Vincent R.
