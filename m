From: rubisher <rubisher@scarlet.be>
Subject: Re: sparse 0.4.2: cgcc issue
Date: Tue, 08 Dec 2009 19:03:37 +0000
Message-ID: <4B1EA309.7050106@scarlet.be>
References: <4B1AE007.8000509@scarlet.be> <4B1B9D2A.6080804@scarlet.be>	 <70318cbf0912070110ic52222xbb7c7be5829129f9@mail.gmail.com>	 <f43fc5580912071004r1df4949p5ce0003017b82d5b@mail.gmail.com> <70318cbf0912071847s5dc57120v437ae6ea3131b143@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040109030802000508010607"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sif.is.scarlet.be ([193.74.71.28]:55450 "EHLO sif.is.scarlet.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965777AbZLHTDg (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 8 Dec 2009 14:03:36 -0500
In-Reply-To: <70318cbf0912071847s5dc57120v437ae6ea3131b143@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, linux-sparse@vger.kernel.org

This is a multi-part message in MIME format.
--------------040109030802000508010607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher Li wrote:
> On Mon, Dec 7, 2009 at 10:04 AM, Blue Swirl <blauwirbel@gmail.com> wrote:
>> My Perl skills are not very bright, but the suggested patch
>> (http://marc.info/?l=linux-sparse&m=126010091922942&w=2) looks
>> correct.
> 
> Same here.
> 
> Rubisher, can you please send me a Signed-Off-By: line for the patch
> you submit?
> 
> Thanks
> 
> Chris
> 
if that could help you:

a possible fix to cgcc issue in sparse 0.4.2:
	Use of uninitialized value $bits in exists at /usr/bin/cgcc line 139.
	/usr/bin/cgcc: weird number of bits. at /usr/bin/cgcc line 139.

Signed-off-by: Joel Soete <rubisher@scarlet.be>

--- cgcc.orig	2009-11-28 17:41:28.000000000 +0000
+++ cgcc	2009-12-06 11:55:32.000000000 +0000
@@ -133,7 +133,7 @@
      my @types = (['SCHAR',''], ['SHRT',''], ['INT',''], ['LONG','L'], ['LONG_LONG','LL'], ['LONG_LONG_LONG','LLL']);

      my $result = " -D__CHAR_BIT__=$char";
-    while (@types) {
+    while (@types && @_) {
  	my $bits = shift @_;
  	my ($name,$suffix) = @{ shift @types };
  	die "$0: weird number of bits." unless exists $pow2m1{$bits};
=== <> ===

Also attached in case of mail client issue

Tx a lot,
     J.

--------------040109030802000508010607
Content-Type: application/x-gzip;
 name="CGCC.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="CGCC.diff.gz"

H4sICHWiHksAA0NHQ0MuZGlmZgBlT11rwjAUfba/4lCKVdpI087pKkL2AVMQB863MYLWVANW
pWlRkf33JXYqzPuQ3PNx70kIIUiWSdLa5nJZC4PgiVBKwi5oJ36gcdhtBZeCZ07L87zzxJ85
JMEjKI3b7TgK78yMgdAo8jvwqosxC6ayI1hx3AmFPhpf7ufr4Hni+q777UOjwWR6BcPxrR99
jN81GN0Qv1D/uZuglWbPwjXXyYUq14UOtkHeODfR/GU45bzvJKtZbvcsYqz7lVwLNKpnNnGy
vDsW9ToYNxpqZvNcFuZDaiXTQgu9im44m1kmfEeVaSoPTW1gp4unWvNjnAspYDtBjL2Q+QKb
MpuLHNsUZmvLRrlZC6UgDlLpFGe33YcZPZ0z9fwvyU/n38kBAAA=
--------------040109030802000508010607--
