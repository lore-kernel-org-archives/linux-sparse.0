From: "Christopher Li" <sparse@chrisli.org>
Subject: Fwd: [PATCH 0/10] Sparse linker
Date: Wed, 3 Sep 2008 18:16:24 -0700
Message-ID: <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
	 <70318cbf0809031808u8610f3h4b3d53a7b76a7799@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:12061 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYIDBQ0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 21:16:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so297706fgg.17
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 18:16:24 -0700 (PDT)
In-Reply-To: <70318cbf0809031808u8610f3h4b3d53a7b76a7799@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, alexey.zaytsev@gmail.com

Oops, forget to CC the list.

Chris

---------- Forwarded message ----------
From: Chris Li <sparse@chrisli.org>
Date: Wed, Sep 3, 2008 at 6:08 PM
Subject: Re: [PATCH 0/10] Sparse linker
To: alexey.zaytsev@gmail.com


On Wed, Sep 3, 2008 at 2:55 PM,  <alexey.zaytsev@gmail.com> wrote:

> more on the subject, I now agree that we should include the
> intermediate code representation into the object files.

Good.

> for this is a four byte overhead prepended to every
> serializable structure by the allocation wrapper. Also, you

I would rather not have that 4 byte prepended to every
structure. Serialize is just one short stage of the life cycle
of those c structures. Having the permanent extra space
for just that is unnecessary. That 4 bytes meta data also
limits what C structure you can work on. All you need
is being able to map a point into some serialize object
to keep track which object is tracked and which one is not.

After you serialized the data. The meta data can be drop
completely. So the price to pay is for every unknown object
pointer, you need to do a dictionary look up. Only during
the dumping stage. But that price is actually very small,
when you dumping objects. You are mostly limit by the disk
any way. The plus side is: you can work with any objects.
You don't need to waste extra memory for serialization
when you are not doing serialization. You can leave the
object allocation code unchanged.

> have to use a macro when declaring a serializable structure
> (or an array of such) statically. One limitation I was unable
> to overcome is the inability to work with structures used both
> stand-alone and embedded into bigger ones. Luckily, we have no

Like the ctype member inside the "struct symbol"?

> list and serializing it [PATCH 07]. The linker needs to dlopen

Do you use the stander share library for dlopen and dynamic linking
the sparse objects?


> the input "sparse objects", merge the symbol lists, and
> serialize the result [PATCH 08]. The generated code compilation
> is handled by the cgcc, cld and car wrappers [PATCH 09]. To
> look up symbols in sparse object files, a simple program is
> included [PATCH 10].

Do you dump your sparse object in ELF format?

Chris
