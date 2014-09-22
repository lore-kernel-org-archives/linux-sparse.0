From: "Rustad, Mark D" <mark.d.rustad@intel.com>
Subject: Re: [PATCH] sched: Remove nested extern
Date: Mon, 22 Sep 2014 19:32:04 +0000
Message-ID: <D428C53D-F663-4846-ACAB-74922033B048@intel.com>
References: <CAFLxGvwfuE-458duC9ARMLLMBCvZaBQnwDjPW6uJC4FAViBXjQ@mail.gmail.com>
 <20140922175511.62229.98784.stgit@mdrustad-wks.jf.intel.com>
 <20140922190128.GA2805@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="Apple-Mail=_8CCC8EA9-24BF-4637-A31E-5A11B69304C9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7890 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbaIVTdg (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Sep 2014 15:33:36 -0400
In-Reply-To: <20140922190128.GA2805@worktop.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "sparse@chrisli.org" <sparse@chrisli.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>, "computersforpeace@gmail.com" <computersforpeace@gmail.com>

--Apple-Mail=_8CCC8EA9-24BF-4637-A31E-5A11B69304C9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Sep 22, 2014, at 12:01 PM, Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Sep 22, 2014 at 10:55:11AM -0700, Mark D Rustad wrote:
>> Avoid W=2 nested-externs warning by moving the nested extern to
>> a normal extern. This eliminates that warning which is generated
>> for every inclusion of sched.h in a kernel build when W=2 is used.
>> This also removes a point of maintenance if the definition of
>> delayacct_on were ever to change.
> 
> Yeah, so why is that warning worth using? Just disable the warn if
> you're bothered by it.

I assume that nested-externs is included in W=2 because many uses of
them, especially with function prototypes, creates a risk of inconsistent
declarations. The kernel has a fair number of them that seem to have
been added to disentangle include files. If they are judged to be
worthwhile, then it would be good to silence the warnings so that
attention can be given to other instances of the warnings. If those
nested externs are not worth the risk, well that is a different conversation.

-- 
Mark Rustad, Networking Division, Intel Corporation


--Apple-Mail=_8CCC8EA9-24BF-4637-A31E-5A11B69304C9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJUIHkzAAoJEDwO/+eO4+5u45wP/11SArEWtpADJbQnAfcGPBR3
qlryiWpF9e5hqj55QFSFIcg+Ff9KxGKo0tq2ZwxAY4oA+46J09TuvsAtEzHrIo+v
My+e5l9ToMbEk7/PjUGVw/Xl/0pgFMQ50trPkHQyG0VJezjKfJAzM2TKmJCqYpt8
croy6C9spXlajEcLnN67XWgUsAz02y+m/kKwZEpYQKzqg+aaC7Qm811AgxXdFZ0y
Oft1t+DmA+RQXi1Dgn6jI3LPlH02Y10fiubSbAe2uEAvcj9A4lqXli9PIe37Rr3o
urSTWwWgidMz43ZHAznRZIknTXOKQq9l8O7JqvejfOEP9J/HsD9Yg5/Xmo5Wvgm+
5QGKjtTqcEH2zG4vhAmHxkwOjPQwaDZTrEiWraacrlFp1znfW2U43qzMqcPQ0vme
2khFZdfaZI2jqi80BMb6sYuYdO36kV5UKilCfGjo3NNjZvXt/rzey2nSHXhvLFS4
kPINyajdqp8k1UBOW/902WST5ljWipdaV2QAfsLC7QH372Gc+f8A/08xv8xio+Uc
Frmmy4Kk2VjdSgJcAdUoJwD2YLUnFBXEcIrUO546xsu/ELLfAGTXcCcSbcp2pksX
WrKdJNGbebB707ezrVc6Tq3lrft2qX7JJ2/rXaSMOFNPdr1BmDhO39aliiPSynGZ
0PSiRgJwmg1v/hQBOA7Z
=B3pP
-----END PGP SIGNATURE-----

--Apple-Mail=_8CCC8EA9-24BF-4637-A31E-5A11B69304C9--
