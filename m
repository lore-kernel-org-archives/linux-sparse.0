From: Mauro Dreissig <mukadr@gmail.com>
Subject: Re: [PATCH 2/2] ptrlist.c: fix a typo in a comment
Date: Thu, 02 Aug 2012 11:56:34 -0300
Message-ID: <501A9522.8030802@gmail.com>
References: <1340055561-28496-1-git-send-email-j.neuschaefer@gmx.net> <1340055561-28496-2-git-send-email-j.neuschaefer@gmx.net> <5019ED0F.6080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48800 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab2HBO4i (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Aug 2012 10:56:38 -0400
Received: by yenl2 with SMTP id l2so8799259yen.19
        for <linux-sparse@vger.kernel.org>; Thu, 02 Aug 2012 07:56:38 -0700 (PDT)
In-Reply-To: <5019ED0F.6080507@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On 08/01/2012 11:59 PM, Mauro Dreissig wrote:
> On 06/18/2012 06:39 PM, Jonathan Neusch=C3=A4fer wrote:
>> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>> ---
>>  ptrlist.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/ptrlist.c b/ptrlist.c
>> index 2620412..5dc1117 100644
>> --- a/ptrlist.c
>> +++ b/ptrlist.c
>> @@ -35,7 +35,7 @@ int ptr_list_size(struct ptr_list *head)
>>   *
>>   * The array to linearize into (second argument) should really
>>   * be "void *x[]", but we want to let people fill in any kind
>> - * of pointer array, so let's just call it "void *".
>> + * of pointer array, so let's just call it "void **".
>>   */
>>  int linearize_ptr_list(struct ptr_list *head, void **arr, int max)
>>  {
>>
>=20
> Hi!
>=20
> It looks like the comment was left there by mistake. I belive the ide=
a
> was to call the second argument void * to avoid warnings when passing
> other_type ** to the function without having to cast it to void **.
>=20
> Reading the comment now only gives the idea that declaring the argume=
nt
> as void ** instead of void *[] gives different semantics, which is no=
t the case.=20
>=20
> Mauro
>=20

Ah, I think I get it.. You cant cast something to "void *[]". sry :P
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
