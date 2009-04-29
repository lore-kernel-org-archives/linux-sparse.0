From: "Alexander Sorockin" <sorockin@yandex.ru>
Subject: `char * s = "abc";' causes compile to crash with a segfault
Date: Thu, 30 Apr 2009 00:53:14 +0400
Message-ID: <op.us51m0w9ucb9g9@home-5db3af48a>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from forwards2.yandex.ru ([213.180.200.23]:50902 "EHLO
	forwards2.yandex.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbZD2Uxu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Apr 2009 16:53:50 -0400
Received: from smtp9.yandex.ru (smtp9.yandex.ru [213.180.223.91])
	by forwards2.yandex.ru (Yandex) with ESMTP id 22B274C43B5
	for <linux-sparse@vger.kernel.org>; Thu, 30 Apr 2009 00:53:48 +0400 (MSD)
Received: from net179.144.91-83.espenza.ru ([91.144.179.83]:39943 "EHLO
        home-5db3af48a" smtp-auth: "sorockin" TLS-CIPHER: <none> TLS-PEER-CN1:
        <none>) by mail.yandex.ru with ESMTP id S65719AbZD2Uxn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Apr 2009 00:53:43 +0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I realize that compile is only an example and you are probably familiar  
with the problem, but just in case... I was playing around with compile  
and here's what got.

------ In Linux (sparse-0.4.1, gcc 4.3.3):

$ ./compile -
char * s = "abc";
-:1:6: warning: symbol 's' was not declared. Should it be static?
	.file	"-"
  =
Segmentation fault

------ In CygWin (sparse-0.4.1, gcc 3.4.4):

$ ./compile -
char * s = "abc";
-:1:6: warning: symbol 's' was not declared. Should it be static?
         .file   "-"
  =
       7 [main] compile 1676 _cygtls::handle_exceptions: Error while  
dumping state (probably corrupted stack)
Segmentation fault (core dumped)

------

Just out of curiosity, is sparse stable enough in general to be used as a  
full-fledged front-end for a C compiler?

Best,
Sandy
