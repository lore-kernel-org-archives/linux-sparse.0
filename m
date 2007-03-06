From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: sparse segfault in kernel -mm tree
Date: Tue, 6 Mar 2007 14:28:24 -0800
Message-ID: <70318cbf0703061428u138a64b2x117eebdb915be50@mail.gmail.com>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
	 <20070306023351.GB31138@chrisli.org>
	 <20070305210416.7b5c0a2a.rdunlap@xenotime.net>
	 <20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
	 <20070305224025.fe867c28.rdunlap@xenotime.net>
	 <1173205177.32333.34.camel@dv>
	 <20070306125846.0e3a684a.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_185733_17820055.1173220104576"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:9201 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406AbXCFW21 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Mar 2007 17:28:27 -0500
Received: by ug-out-1314.google.com with SMTP id 44so340192uga
        for <linux-sparse@vger.kernel.org>; Tue, 06 Mar 2007 14:28:25 -0800 (PST)
In-Reply-To: <20070306125846.0e3a684a.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

------=_Part_185733_17820055.1173220104576
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is my version base on your email.

I need to change the gcc include path though. But it does not crash on me.

I did not get crash on allmodconfig either.

Chris

On 3/6/07, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On Tue, 06 Mar 2007 13:19:37 -0500 Pavel Roskin wrote:
> OK, that produced a large .i file and running:
>   sparse vioc_provision.i
> does reproduce the segfault, so now I am cutting down the size of
> the .i file, then I'll send it in.
>
> Thanks.

------=_Part_185733_17820055.1173220104576
Content-Type: application/x-sh; name=bad.sh
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyyvv43y
Content-Disposition: attachment; filename="bad.sh"

c3BhcnNlIC1EX19saW51eF9fIC1EbGludXggLURfX1NURENfXyAtRHVuaXggLURfX3VuaXhfXyAt
V2JpdHdpc2UgLURfX3g4Nl82NF9fIC1tNjQgLW5vc3RkaW5jIC1pc3lzdGVtIC91c3IvbGliL2dj
Yy94ODZfNjQtcmVkaGF0LWxpbnV4LzQuMS4xL2luY2x1ZGUgLVdwLC1NRCxkcml2ZXJzL25ldC92
aW9jLy52aW9jX3Byb3Zpc2lvbi5vLmQgLW5vc3RkaW5jIC1pc3lzdGVtIC91c3IvbGliL2djYy94
ODZfNjQtcmVkaGF0LWxpbnV4LzQuMS4xL2luY2x1ZGUgLURfX0tFUk5FTF9fIC1JaW5jbHVkZSAt
aW5jbHVkZSBpbmNsdWRlL2xpbnV4L2F1dG9jb25mLmggLVdhbGwgLVd1bmRlZiAtV3N0cmljdC1w
cm90b3R5cGVzIC1Xbm8tdHJpZ3JhcGhzIC1mbm8tc3RyaWN0LWFsaWFzaW5nIC1mbm8tY29tbW9u
IC1PcyAtbXR1bmU9Z2VuZXJpYyAtbTY0IC1tbm8tcmVkLXpvbmUgLW1jbW9kZWw9a2VybmVsIC1w
aXBlIC1mbm8tcmVvcmRlci1ibG9ja3MgLVduby1zaWduLWNvbXBhcmUgLWZuby1hc3luY2hyb25v
dXMtdW53aW5kLXRhYmxlcyAtZnVuaXQtYXQtYS10aW1lIC1tbm8tc3NlIC1tbm8tbW14IC1tbm8t
c3NlMiAtbW5vLTNkbm93IC1tYWNjdW11bGF0ZS1vdXRnb2luZy1hcmdzIC1EQ09ORklHX0FTX0NG
ST0xIC1EQ09ORklHX0FTX0NGSV9TSUdOQUxfRlJBTUU9MSAtZm5vLW9taXQtZnJhbWUtcG9pbnRl
ciAtZm5vLW9wdGltaXplLXNpYmxpbmctY2FsbHMgLWcgLWZuby1zdGFjay1wcm90ZWN0b3IgLVdk
ZWNsYXJhdGlvbi1hZnRlci1zdGF0ZW1lbnQgLVduby1wb2ludGVyLXNpZ24gLURNT0RVTEUgLUQi
S0JVSUxEX1NUUihzKT0jcyIgLUQiS0JVSUxEX0JBU0VOQU1FPUtCVUlMRF9TVFIodmlvY19wcm92
aXNpb24pIiAtRCJLQlVJTERfTU9ETkFNRT1LQlVJTERfU1RSKHZpb2MpIiBkcml2ZXJzL25ldC92
aW9jL3Zpb2NfcHJvdmlzaW9uLmMK
------=_Part_185733_17820055.1173220104576--
