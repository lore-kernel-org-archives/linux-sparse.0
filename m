From: Christopher Li <sparse@chrisli.org>
Subject: Re: Re: [PATCH] Fix implicit cast to float (Was:Re: Initializing
	float variables without type suffix)
Date: Mon, 9 Feb 2009 11:15:58 -0800
Message-ID: <70318cbf0902091115l338eb247x2d4f42d154ba0a43@mail.gmail.com>
References: <70318cbf0902082337r250543c8ic94c0f8f6517565a@mail.gmail.com>
	 <OF56CB73D3.5EA2DB0D-ONC1257558.00499FF2-C1257558.004AEC1A@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:57990 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbZBITQA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Feb 2009 14:16:00 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1926004rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 09 Feb 2009 11:15:58 -0800 (PST)
In-Reply-To: <OF56CB73D3.5EA2DB0D-ONC1257558.00499FF2-C1257558.004AEC1A@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, linux-sparse@vger.kernel.org

I guess you apply the patch on the official sparse's tree.

The patch is base on my development tree here:

http://git.kernel.org/?p=devel/sparse/chrisl/sparse.git;a=summary

is_type_void() is introduced at change 405cd6edfe2e88c808f0a45f0c2ef92a854dbe67,
warn about explicit usage of sizeof(void).

Chris

On Mon, Feb 9, 2009 at 5:38 AM, Thomas Schmid
<Thomas.Schmid@br-automation.com> wrote:
> christ.li@gmail.com schrieb am 09.02.2009 08:37:50:
>
>> On Fri, Feb 6, 2009 at 4:51 AM, Thomas Schmid
>> <Thomas.Schmid@br-automation.com> wrote:
>> > christ.li@gmail.com schrieb am 06.02.2009 05:15:37:
>> > -       if (newtype->ctype.base_type != &fp_type) {
>> > +       if (is_int_type(newtype)) {
>>
>> I change your patch a little bit. The old logic of testing against float
>> type is better. The type can be a pointer for example. Then using
>> the long long value is more correct.
>>
>> See the patch attached.
>>
>> If there is not objections. I am going to apply this one.
>
> Thank you for correcting, your changes work fine for me.
>
> There's only a little problem with the patch,
> patch breaks off in evaluate.c, cause there's no function "is_void_type"
> within...
>
> Greetings
> Thomas Schmid
>
