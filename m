From: Josh Triplett <josh@kernel.org>
Subject: Re: Sparse and the Google Summer of Code 2008
Date: Tue, 11 Mar 2008 21:28:53 -0700
Message-ID: <47D75C05.4090807@kernel.org>
References: <f19298770803111038o3655a216vfe5a4b46876e7218@mail.gmail.com> <47D6CD7F.6010800@kernel.org> <47D734C2.1020903@knosof.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF472A502B7E1D6B7E9D3F375"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:40842 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbYCLE2y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 12 Mar 2008 00:28:54 -0400
In-Reply-To: <47D734C2.1020903@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF472A502B7E1D6B7E9D3F375
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Derek M Jones wrote:
>>> I know, last year was not all that successful, but maybe
>>> there will be more applications this year. I've got some
>>> ideas about abstract interpretation for one. I can't promise
>>> that I'll choose sparse, there should be lots of interesting
>>> projects this year, but there are other people as well.
>> At least one other person has asked about Sparse and SoC, which
>> suggests that some interest exists.  I'll work on getting the
>> org forms filled out today.
>>
>> If anyone else on the Sparse list has an interest in mentoring, please=

>> let me know as soon as possible.
>=20
> The ideas so far proposed are major undertakings.  The sort of
> thing a summer student will only scratch the surface of.

To clarify, I wouldn't expect a student project to do everything
necessary to complete any of the areas I mentioned.  I wouldn't expect
complete handling of contexts, or a complete port of an extensive test
suite.  (And the comment about code generation falls under "sarcastic
offhand remark", not "project suggestion"; anyone wanting to do that
should scale back their expectations significantly unless they have
lots of compiler experience.)  On the other hand, a student project
could reasonably add one or two additional things to context checking,
or do a proof-of-concept port of a handful of tests with some
underlying infrastructure.

> I think it would be useful to analyze the Linux bug history,
> looking for known faults and their fixes, that are currently not
> detected by Sparse, but which look like they are amenable to static
> detection.
> If more faults are required there is always the BSD bug list.
>=20
> If the existing faults were categorized it would give some idea
> of the kinds of constructs that ought to be searched for.

Agreed entirely, and that sounds like an excellent project possibility.
Any additional useful warning in Sparse represents a good contribution.

- Josh Triplett


--------------enigF472A502B7E1D6B7E9D3F375
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH11wFGJuZRtD+evsRAvSXAJ0T1v7dCFz5Om8Hwa4WdmLwQ/dExACdE9Oo
ZqZKGldeckART/D6jexkXv0=
=iYw/
-----END PGP SIGNATURE-----

--------------enigF472A502B7E1D6B7E9D3F375--
