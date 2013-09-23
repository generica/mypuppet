class admins {

}

class admins::systems-team {
    include brett, brett-home, brett-laptop, not-brett-vpac, jin, carlt, carltmini, csamuel, csamuel-home, vera, not-brian, not-dbannon, not-clayton, not-briano
 }
 
class admins::ibm-systems-team {
  include james, mark, not-simon, jeff, matt
}

class aisaac {
  ssh_authorized_key { "isaaca@isaaca-laptop":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAABIwAAAQEAwZE6mXmgv0V7xk+tfY3qrehKbXgwNGdi8GtMwANl+/8iojWYziYfPSE4qPAXAJyYiZ0oEZyw6iFx0+5908F6XIzjfYo8wycftIfTOeEL+XHA9Ng4qP9wGR4rtIGDHgm1qIp1zTVEwT61Yt3RGGsdcvVs/CB23VhzracfHwfaW/bPEzyRbHSXam9AozQhZBpKNzhsB4ihaWWffkFqEGim9a+dpUX8/SswB9LYKy1F6CjXf199CIhGnIpoR7X0zsot8HEfRvZNVuV7y2aVBSZjtLQTU3onIFBE2hG9Fb50cSmklWZ2oQToUCHIl/8Js4JG2KSm1evEUFUqRvyrJgsBmQ==",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-aisaac inherits aisaac {
  Ssh_authorized_key["isaaca@isaaca-laptop"] {
    ensure => absent,
  }
}

class bernie {
  ssh_authorized_key { "bjpop@floyd.local":
    ensure => present,
    key    => "AAAAB3NzaC1kc3MAAACBAJkiIoGKGMCA5g17LAj+DB3i27qIRmJl7DjZ4ONfHAbi1bDxiWPTDMWheDLSe7TE/YKkedzgGYIN8B8wFym166yY4JH7O8K4c7JlIMOPFe0VKKfG8XoYB7eDS7qdSQwEDeNWl2XCgvt27d7xpP44qT+WyXhO8pNaOCyP0G4ZZ6m5AAAAFQDgL/j44S0P3ms47Wt0QGQ1u+B8HQAAAIEAgirwiHbhI9YAhD+VgA/T84GHS2GyrCdQppkUYssdNMyPZnHIJTkd6flixDy55jyzQCZ6vUnXYl1KbrIH407X4szv8UnJltSEWwk4TpCCxD5xK8NufN+fWAv0pRuVFQLtAz16DpWSA1pOYWCVriWi4zhikOsLMWFoNQ75JmBRsCkAAACAedkkz6Il/4USZAJyQ26Qup6v/r+7rDgUHtkuDsVixVj2dZWr3dBvqPhPcLLACpsSKbccPQpk7UdOY1HT+rwAq/Ocu+vZqi69GRIkU3CNbwHdWuRlgk44xon/fDTxvDecsDaoU8D0M4WyCLLpgWB6teu0qkp3TF+ZNikqmtf14Ts=",
    type   => ssh-dss,
    user   => root,
  }
}

class not-bernie inherits bernie {
  Ssh_authorized_key["bjpop@floyd.local"] {
    ensure => absent,
  }
}

class brett {
  ssh_authorized_key { "brett@sys05b":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAABIwAAAgEAwT4gqv7CDRYOA8W7jZ10O4Zxk71QbPHeMmkIXgp3vUnplsUrU6/qB6mLG7+Hz/ZZUk4BnYio5QXzBCmzH/I/L1FPjnHM8EjGdd4hAxYwZ6F/0v5d4p+vRF9yrLGLkbPoYPCvnF7rramYR2tCkeavAu9czKIja77cTbWy49ouZPcbxAFovSh6bg3hsgiwTPHd7RCYepBhh9+aqzydMBUwx4xb8tgH7BmU7IUq3yC4edpAf2zSfor9fvSroU7dv4jwmCxk7tzpv5leP3kQsKmU1MLcPNoJ+Aur5De+yXjdX2sBD1LuyANPXcBwfUtKh4dZV7bP38/dWJ82H+uDA9Uv2T/nTxvBvVxnKSI2hx8ay+bRu7S98A3TNZUHYPDhc8cX5AyYSTbPVd6D5kbehFpyxTjDV0zRSeZzl5r8vAbSJtbg6oX18HlLuE2L7aoqwv4PF33MxFpgD5PLAw1AON3xvsLqWkNqa5x9+GsC0DTzhhTBJQ7sOI8YTuLUbFaEMBGTpIDKLGR1b1AoinnMvoGzA9bjSLP5O7eDQEaKYrf/zANGaRQMWvibq2nYPnMdD0UAzaoHqE79v3vNV+bsRCQaAbQtyL312Nq88dXnWH4hntZotJ0uv2VYEp7TNXpl2f3LXDXPeI4l8nDe0e6KTFYA0n20rOpBTI67NHeOizwvPs0=",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-brett inherits brett {
  Ssh_authorized_key["brett@sys05b"] {
    ensure => absent,
  }
}

class brett-vpac {
  ssh_authorized_key { "brett@sys05":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAADAQABAAABAQChxzc+antMejlF5F9ggEl3dJkbPhDDHbMlZAxHN38xqioNF0xRA2/Y2bBd1pR+SvH0s48QTZXwf1W7QflrRKwd/GuKRCKUmpzFjPAj9gfYpVJd6/cUCarSi555B7gXmg+V8z0yVQ6jlKoq0unDYyp46NBpb66uDm2UPYruc0NkATo0RiZnfPVRMikBEahaRTEMsqS5u7MbRDTCDF4L5zzxy/jkXvALs6Y4Xe6pEddEfjILeuWcuWs5nXdT7QQ2clXnF0/Ck2c+bisFHHHDy4FeEmrw4hiH3yOcrRE+Z5B4svTkoPrcBeOxKDZb9SpVv5564WLovD/5nH/zG5L0c8Dl",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-brett-vpac inherits brett-vpac {
  Ssh_authorized_key["brett@sys05"] {
    ensure => absent,
  }
}

class brett-laptop {
  ssh_authorized_key { "brett@apsis.local":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAADAQABAAABAQC0isCx8xzsQiSMx+L7rGJo0rs3b+Jy74AbXT8071DgH8qCeYug1sUnRFUmoaF5XFPyMSQ6dmvKFF49Et1MgdbiV4IWIIyLTFmkU5W8jB2Myk01c+kWYz//f1dS42ZNqo21o04MV1SmioojM89EYxaiw7IszANCbTFZiN4R7jlTpgqUIczrLNGbqwFcshCLc97qyJc5t1VO5zHuaxeafuJcPbLtzIAB3gQTfovTIKiWbvEeywwASsbYt2qFeZWWb+mJo1y3ZtoGLptBSBDZvVRU/GaHvadHozRX32YVCZ8ImpLedtHYLWatvovc9kK96xPg1YNO4a8ThmJuwvq9J6QF",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-brett-laptop inherits brett-laptop {
  Ssh_authorized_key["brett@apsis.local"] {
    ensure => absent,
  }
}

class brett-home {
  ssh_authorized_key { "brett@capsid":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAADAQABAAABAQC/B2kuS0FP6cRnJM7KZBuXmo+XKBOfTWiTVv4ftB3CAnwV+Hv/Ny7N0ii6IPrjMB/M2oLaifocxoj6PHTcuyiD0gu7FuFcIuNKduvd2MJNL9laY0Wfep1OyJCd0s7287iA8KZWBDyVyqfkqJPVlNeErAA0lIkuZ8xKGeVPajSTPX6U+qXvsshTiZkkvAHgje3zoMNRPfU0MLHJC0SEjYa9BZZszwTSAIschsZwdlhXOt1pV5jmiCARxhDeAYutx1twUrU9Bc96koVf4RAGMwaGQZbbQqDDfLz279W9iobBu4Dt7rI+PSC82In6OVVhALOONgT2encbntDV6UsguRWb",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-brett-home inherits brett-home {
  Ssh_authorized_key["brett@capsid"] {
    ensure => absent,
  }
}

class brian {
  ssh_authorized_key { "brian@sys11":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAABIwAAAQEA1oYw4zu2m0DPHOOUmRflxTYuBn3Ss/DGhoG1hzHGUBsTYBaJKaycPRVSLO4MC9TibKfVoLIm9Kdjh+sWcyn5xx0/jmmc+cEYXvrsnYu6lwYoMEizYXYNn0Aom3c4ry7E/A35edLLpHVhgSZQ48E7u677NrHfBuFoLASvbTjs/EnU1aidBojhOHw7iEWT93mA/uCoY3TLQmjOvqvk+jreLq18oUnytEp9CuLOxOOW2BEQ6oIwUstdcLuPofZgPb6GHzULVcHC4OnddAY24L8JhGrCETFVBWD6azX8NAwc5+ykuhBgVi7Rc1zEFJ5PpylTEDIHiBhJuABpuwU1Gg7X6w==",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-brian inherits brian {
  Ssh_authorized_key["brian@sys11"] {
    ensure => absent,
  }
}

class briano {
  ssh_authorized_key { "briano@bruce-m.vlsci.unimelb.edu.au":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAABIwAAAQEAy0LdHqZDlfiYH7wkRopRMR5qyj1rPRz1qt8B4AgURVBGl8As2JBklP7lnpKX0rIUq89Mf8p1yIYaN7k1tcz4Z6d5t4VaIiVht+6IpAFeZcXAi30YBcBnJQxeC0wWPvV84S1K/iVUWUdHGI5qBIxbM/LvXCuthTWUaDasWpxK/uagey54ZkM8/BDo2QmcD/IrSz1JvGOpeiw7Mxn7yed1k6EWPONI1zp8bDFHSUYVhtj5GiN8CMUx+awmVyUWcvMfhxYeo2VbDAaSAsszmlDHShdgVeI1Jmog+PUK2O+0ZSehdv0x5IfJT/0l916540ETBmCzSYc58ymrS0Yt8sMPpw==",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-briano inherits briano {
  Ssh_authorized_key["briano@bruce-m.vlsci.unimelb.edu.au"] {
    ensure => absent,
  }
}

class carlt {
  ssh_authorized_key { "carlt@Llama":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAADAQABAAABAQC6RV1Xvfjm3gQpavdZS9bywQ+OAQsUy6+LzZdvhJvby40Plk7ES+tfPLpqWFUCRnZ1KrxOzFPej9EJFLg9OEzf9Z9htzdH95KL2RC6HBexkd5o5bhlR+5dwe/uvuUILWn9uShs4gESwRy9VTJLdXdkP1zhCJH8UyWuM1yJ2dNL6MD3wSNq/gCPRsSxZli23Arp0i7yaOw2NVRbO+tAsK1dOG6b8qS0BS7k9khSSHjLYzDQ245+kZAkVpJqIlI7l6m+V6lbnVtp56GiztVohhfRSP/AaWGtqYUV3ZvxfAlBWt+dG7cK3CGsNj+tL+Y/5wJUD3Oj82l1I5kG9nHzanQV",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-carlt inherits carlt {
  Ssh_authorized_key["carlt@Llama"] {
    ensure => absent,
  }
}

class carltmini {
  ssh_authorized_key { "carlt@Carls-Mac-mini":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCpGXk8WMseJpYi+cJVfTW34ABpFg0WXrWMIus2Vjq1l7e0cDSjr3ZkEED+B85kQdBPuR4r1bUscxfocW65ULbWtju/vWUcylQMwyrU8cTpGF1lLCliy3KY/kWx+oTPL4uyBHt3A4AjH7OZLJRINu5gtI8weThoEMbwJ92wVyf29gl9Sgvy++K6vh6MDwId2DZktqbcWAbCFd79VKSvOI5ARIKDiwd1Q7z8MZ5xcfdgq2S/fLEPVFrj01VlljGknmuVmNROPULZXEEd6RtGGEWE0WJ1+ab0RsFVPqC6qJZW7UXzt7zGa2jTm0ByOkCBaaJjJKc6ysCJAlusOoqSqePF",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-carltmini inherits carltmini {
  Ssh_authorized_key["carlt@Carls-Mac-mini"] {
    ensure => absent,
  }
}

class clayton {
  ssh_authorized_key { "clayton@bitbucket":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAABIwAAAgEA2UzpcXk2zatAuXEL7AHAz5GkGhJbr7PIYYIvxhRnH/PXPNH+5fJukjUos8GzfasowQ9cH8lKb/GtIZ/Sd9hLEM1b/YCCOC218/5HSMhVg3ZmVUgFpjIpJI4abYXq9SxEEU0X7FSJW/rtOtvC7/fZTEOJTUvYdySO/UcHb6nEAEF0S5xma5VNSX27XLVx5p/FtdsA7echzF1azVluur4L0mm5IMmaN2S4ycMj0nfBk5IAOKNb+M9oTTlh1TyUPdGZtM+so6F1GXa5gNtPVBoOxkGLGMZGPXMBoRWUiSbxY87J5Z+oAw5Cmjl5rT6P919V/GaDnj02UqTR48dhB+QNUVN7ULr9cRB8Z32xxf/QD81r16OTwEMH69IYA7pWwgzRG2CHrsdGpyVdi+1H12H+8NR6zAXNVoDrUSysd4IbHkip200KUbAGWZHRZo7526Yu+9mjdBzOVHFfw0xYd5E3M0Jg0zqAeOu/isyGxC+GG+LWwLvI6CFwZUX0jKE78kitVzYsUpaPSq3887RmcB48GZ4DP5847Vam0csXjhjDV3Nle+dBIUdcLTjsd5jGFtXyBOBqw9u90vnmCxaDNbwD6qfSyukbUveIkGZos/prhgZNlfVX2wlBUddMGUo80i/pa1Joc6ftRZl22G8Rx+9N68vVugxGdnF/mdQ6LouB39U=",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-clayton inherits clayton {
  Ssh_authorized_key["clayton@bitbucket"] {
    ensure => absent,
  }
}

class csamuel {
  ssh_authorized_key { "csamuel@dell006":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAABIwAABAEAv+wdT2ARKB4/zaEyiN/HZ4BVoP6nRdB+csPpZ+9k+mYmUehgRT4S5DJdSmi2J2zHtxP/6cjc1Cz92CJts9sY71O1gE0dRX2NPsmYbeX+yY8E2zo9wAbrJ3qchgr/aaljZ9Qg9Swu92Dl9L5SSQ7iU/MNrGEOcJxWJ+G3o75SX2oyqRV/ZSdgIJSUC/XcZXtDBJxaTE9FSagAqd0TJjCKFZTtqk0nQHw5jACoXW6LmeI28UYGqkO/0e7D4Di4eSzEEtBQS5mzIksHZFxFRKbVS3aCZsvgb5QhtWpkDL4yeE772Ap5ZxpRi4ELDGqENju7UEU0ir3yDCRjepdHmB8K+6iFtLnhgeUl2S7HRPzdnqSQv4hscFXJrQdmH508OVUcnrePaEfdB82RPGGmspzJOpn0DEnrFlo+rny/v1OxkQtQrozYuHyLKaDsI5IcVybbpAMWVhSISSWzUb3o1ORtht7TMJhthBG9dNvxGpsrdXQ6dHr2qkpFnCV5pd6znYg2s/u7QqhqpAiKlX3XD69iX4tNQaOF+/icAtQzPkbLbmJgt4r3l+DX64c+IUbcVHCN5Fm363uiCUWrP1awOCtHNlzH/xUHbPyVzC6tXl1tz+75IGp1eZ0ktppdl9QYRoKxTc1D4XDDCHqEWzJl165S23eoKn7XJN2+9K6rqXtmnkdBr7wwXB1r+ln7jpx4gNc8D98NfNzp838UT3pJwAbXlQRn0rOOi3FigI1R7NNtrhoStnkMZKSBazfngYG24YjNMf8CB/brhYn7TvjHYl8SfIwz1qvsNRjQ2xAIjWkYkUMLc7NDq+wB4iYo8e+OxbAXMySrWuvGsfrx/tajfepIh2yOfAgM2n7zvv5lwsmK3RkYkBk+EvMF1ffBQubWEp+uW/F0l0DxboDj+46Sx35AZ9QtzcmkeRmtJLASOtxSsEEoZp0px1d6L1UK1yHFj9B6okdVAgtMjr3ZAdnffy1qb8RaBfKLL0SZ12xqGpFCJ++eDGAcI4qR6R6+UbKmIhg8rQvcmHdh7Ndny4n3TGPehDG4nI64HYLcGymKEEJUXJj/S+7IHeFY9ZPzseH3e2A2ImPPjGgnjbGdZ+aycppToi2CiQyNd2YiUzJTxFLLic9uCT5eCqutW3v5ggM5KZ/M9ri5GUmryuZndzaScPiha4nR+oV2acm8pGrzRLFkK29iu/AXnXjgyc5E46WaqEGx8fdn/PLlxh/6P3GM+yPaRko3M2jgDaC3a6mNejFvEoA8YwTDisSfU2ctSTZnIAk6M3fb1HGRSqstrrr3yVI4iHBWsRR6NJDX3knCZousPGKqaL/iOsCd9+Q2rZc1zRFNpX3r5/VwpZvQKiXBXsilkw==",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-csamuel inherits csamuel {
  Ssh_authorized_key["csamuel@dell006"] {
    ensure => absent,
  }
}

class csamuel-home {
  ssh_authorized_key { "chris@quad":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAABIwAAAgEA0emZEGDgVezkdSlO8wfWDMZgdIURH8iHyDCfkA2UhT5R/JUVR6j1xZoMKdYUJwtxcHQbXL0j1W+NqoIkOn69kHIxZa3M09zjhQ2cXoD89AWIQ3iyPXYSibCmi4jQYTpyhKvR2Sth9aMEPtwVcl/DwwCu+eTzrYhS70XEKevaA7/yCE/CqnzkM9CRFtbN6V49l4gYstb4hoMYOlbzh6JSv+6YopKcklelPKOcr9vNIXIqMFUyoI0WBo8Z0hBeXglSX6I7vmAXy7oLN8HgSHkGuumb4sVJoUycn0tr8tZ3lCD7Qr/mJpCJ0QshTrlyU3Vw0Ack1StI0437H0mqHIHARJdfEkuQCydIHKZ/nUbqBNfOXElPW+marRfG/OZFTdAaCbdZbU4qyk1pf+Z5vaPRYR08ilz1PP82e0IMT8YLWgevkmOWB5/+7HpvtapNU3GUVBrw6HQChAC6VFArcvrGJsSK6GaPJ4M6YWU6Yf8IytgipJgEYD1h8hCrRQxHlxNzt88HagvZ0jwA4bMgfY57QusdTVVqFCGXfcsWFuip9G2/Mrd7pC4cI6gjyOEhKMrl6H1c0GSz2JGsKOGrJFHtdqvPjJ6JF5PWoTbS9IW6kPg1hdBGpqgMWkjSe0BGsxOZrvZ2yEQh6xZ/y7ea9MKjx/kPoG5xpPBu5XaiMdLfQy0=",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-csamuel-home inherits csamuel-home {
  Ssh_authorized_key["chris@quad"] {
    ensure => absent,
  }
}

class dbannon {
  ssh_authorized_key { "dbannon@davos-LT":
    ensure => present,
    key    => "AAAAB3NzaC1kc3MAAACBAOgwuC7x3PglSSXKSCCcgF0UNsMU9D/q9gij1TW+YXcfuv0pBiY2dXJmxiusBKMmhXGWiQxUPjKiOzKGBonU/hLeZOFEoQkXFCYigb9BTOkoH3Xkw0iZI7DqNFbI3xYzvIrYFvD82HX8LsP0ZnR181XhZpz6sinHvCe/9hRJGAFtAAAAFQDvexjSut8VWiDG6j/Glzix75KNQQAAAIBvihn3UeXHUHfotXFDo1wucq79vP9O8gH50M24c2FNslUKMy99zUc6mgjVSGYwtyVZ1ZPWf+6O9bgJAeVLfVhv3Xc2UxdOxAC/fL7/wXEh3TPh84cVZM9l7HnKQxt80XT4iQe2VQyULXESZ2O0PrR7MzoEzH08AaVWlwNnNsLnXgAAAIEAirQapFc0JAvtL8Ta6HY5HBLOL7XootJ6FOFS87wVQybdIZUfDRsvwwAa34vBG7ned6z/k5hZGpwIjx3JEUF/KzWzFQfV5qCQN346dFuT7iheFgo1HP1Ns5/rx49jXL0fXesHZi1/21MwocMJvHUM3IaibbF4fUEfO0H0u+F0vfo=",
    type   => ssh-dss,
    user   => root,
  }
}

class not-dbannon inherits dbannon {
  Ssh_authorized_key["dbannon@davos-LT"] {
    ensure => absent,
  }
}

class jin {
  ssh_authorized_key { "root@jzhang8-unimelb":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAABIwAAAQEAwrF06OUHjqRxLuwTwLDtd3Fy6PsEJK6HXHQbjMQHhnqzBhbd0CksBGd1sseGpWhcdBPXRzi9fvaAPydAJpJwPs4uq6Eiorly4AxYnjXqgGGgLOMlI7ut7V499XKLGkDfK92T1g9ld7J/UnsX34b0kkfL7Qle12begyD37WFrqvGOuJe1VN0+zaKohgkZ/JuFkWMj6Ce8FxnRSz8P9Xjr0cyCG/ieSPJvcAd9V8GF67n34JUjNVcotOz0PQXMMnkvy+mPD71yuHBhPjuiT6KlsnZ+Df1HSTlTOKcgt0Q7qbZHjG7Fgtb42+kSym7XcVy54zngqs+JWszReayCyBP77w==",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-jin inherits jin {
  Ssh_authorized_key["root@jzhang8-unimelb"] {
    ensure => absent,
  }
}

class sam {
  ssh_authorized_key { "sam@dell-laptop":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAABIwAAAQEA1en6yGVh/7agSAcrY0zIc8D/unGvoa89A3qGcE7yjU6GsCgVlwWyJlEXuwdFQ9NTmUcC8kbf00OJJvp+kD/DQrXXi8YyX6xAKf8KEe2KuGDlrIGkfj7inoIG64VTybYIc29RferQiXQRRkrDbG2+/Cp4qkk08ToAPP4OYE1f0vh7H2+bCoChrgpcDdXjEQweNfCN66xTBH6k9Bkyzsj3GMfu5TF5Rt52UEyuitXfqq4tBee573tAA1X5tR1JfzJlxGAOrUsqsghQsV/C0u7x1YfRA0MzPq9nS7xoQoVGm2KNKxAKKIKfZoAC991K1w1Pw0oabjL9XRYNrnjLhPrWiQ==",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-sam inherits sam {
  Ssh_authorized_key["sam@dell-laptop"] {
    ensure => absent,
  }
}

class mark {
  ssh_authorized_key { "mark_n@shell.sf.net":
    ensure => present,
    key    => "AAAAB3NzaC1kc3MAAACBAKvW4Bt/AD6hzVIjZ3nWMe9uANPMXwGX1cxVoxM/OAaoFNjAooRnM5gRoYTrSy7unoUEmvVC7/UuTsG9H0nSTlnKy9W+tXmp0JVg5VTsqKmkI04rCgp3KU/MhXN2PJjyp0yCuobh2QG15MtyudKvqJ+JSHL+P1ZwEWJZNXcr7ym9AAAAFQCOOkbIqAclA7WYXAGXN9ZfZvKQ8wAAAIADTv2GwrhhnzHmcFWyQFkrEtfU1rNLH5rhsaukSoA5p6eXZVw1TPl14vzvkaztHIs6m791S3FOoC7UuSjqP4qlUuOPjZZ54tsV0bkdVKEhuJq8h7mfG7xcOWiAMriERkcDn2EVyMWR620F1A6mLnOs+ZI/QagLPFGwrPmgqVN6lAAAAIBEIJBiLrhTeYBUVLIMMkZAaQd9pbcrDqgMoBhKk/pFJEQOqO8TS/CpBtQIJKQhyYU3yA5aPq7rrbd02p4bAw/Sm5M8cffjAp861Cys7/znxUnIrFztlhHB/TXAaFQIOvV5I9F+o/NPLc+qyIswPY+/IzIl3G6uXbTOq2670WQVZg==",
    type   => ssh-dss,
    user   => root,
  }
}

class not-mark inherits mark {
  Ssh_authorized_key["mark_n@shell.sf.net"] {
    ensure => absent,
  }
}

class simon {
  ssh_authorized_key { "simonw@IBM-R8LVAXN":
    ensure => present,
    key    => "AAAAB3NzaC1kc3MAAACBAIyUAaRAFe5SiEx4VJQszONj6yYEwbcNAPpNUSJcUXjfz+pXa4J1SEO4D1i8jS4PaUOYpVtG52nqmKKbaV8LjeiA8T3o4i9VKjKw6MpPTr1btHcoHHURLXuSymcxiWhOOl7gZEqLm0s32kVz28LVpbMiEYuGP+m0nLseCNXdaKyxAAAAFQDKVzDozDToJaccq+dSaLGjxF/riwAAAIBDtUFH8rVReiyaDNTQw+1PPBF+UO0afVHx1VqtLPfzu//PejJmbOQlxrDN5mouPgUHzB7tOiH4SHDB6+jgb9qryrOKIMcBIfe6+MCNFbM5EmFv3L3cYHscDRwokC+0rg7ipWpdT/cp44olHJNb5hyU/0Fllt5eGZ+zlZZ9OqCaSgAAAIBU7wSk480V2wfUWF727VOb5qwlBhRugCII1lru7MtehkHp09fV/GGQDlE8p/bCfNKY5by+nESqdgXwodSHk60Dt/B47gYLEUoB6g7rZYnySaq97DElA+tynNkCLgKP+nUcGBIs03sFKwvf/mShPD/lKZvL6lqt0/F0wEQ3FlIEeg==",
    type   => ssh-dss,
    user   => root,
  }
}

class not-simon inherits simon {
  Ssh_authorized_key["simonw@IBM-R8LVAXN"] {
    ensure => absent,
  }
}

class james {
  ssh_authorized_key { "James Kelly Personal SSH Key":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAABIwAABAEAz22OcHkGDxdomxfWyTtY0v7wsVhQUpzkaZcbrCpPBnG11maRH7hb3X+70UFt7O7QnnGN/ZZYAXonhT0Bd2JcF0e1lMRnzVJacDeCiGWCWLzHdRaY/o0C5x3gWQ4RgLuIJWlNJtj8YwaOwWr4+0mdJHOhuKBg3vRz78/Ndws5CwiDE4aOkmB2ZNE/4Y9CJSnnO+3rqkZh3TV78TY6cwPVRgFOmP6f4ZOjz8EUA+lSAGayPse2e53d1FAqFYtMikHlIjc4J/CYi9413LgZ5D6ion1XI4Eq9/P/M4ZtVZMs6fQIuXBFCgjw17tGHlTNnDKxprxbQ3NQRVFFQpH6u2fuiv9GgmZovO9Af4oM7555mvbKzy6blQMIgiGzSbIpXXvFgWZ/ywb4jMlyfOFnuOvh8C6U19ty5sN+B6Pq/cYdRLk71Nu7wDCEDAAhaRIDYVdV95Cst/Tl+sPLHuVJb8nNyxAfParJ3BJnDdR1LUQO3MJ1lU3vQP1+4t+NlRpVU4B/hDLSXmF7uAxjgziWYJFFm8tP4jw2BouEHJQDuubM0CkpSYj31OHBLUVLryY33+hu/i7uniSqjn/vCXVsqjirSxhhiReHjBiDefUBXHugiqVxE0VMeJ7oCniM3R4AVJYsERLDtWgoIWNCgvIfVievge5atwg5tJiBxHXCm5/7g+GNKGhUCy4NAyH1zd3IV3AYe34ZhyghOPe53aNE3FCKOjQHNmMau6eiGl/xqW6OpdK7eHBt4O4IytUpXXzbccZHkJFadjTcXrgpHAn+oVoFM/kG4mfFFfo0SHenVsmQ9bpGsc6W1pCYHo1vOPBidvGwWwRGj36oIpjcZj0hpphOLlZz1BUwUZQD19dasVrjCLuai7sgZkYNpo+26SR/dvNjvdcePQtBWkxPTlvlodaW/nawo/Uu84tT+JNOHQCNLaPftEPOxl/kwaQPj0mJaHY2IR/KSUZYNhdDAD4xNBD44euevi5sMZ7SRm+FH6yp4LLzG8uW8FJcspoU4I4BHZiJ5nMlD36bRHiZGoE5kTE9ey1qe2FIrseDNfFYtZeCx+lklIR+EFr5f5/iYcPrzi6RHJ7DyJErQZAOVCnB3IkDAz0ktr6hCTLfx1LiQtrN9oX+7oQRcWid2T9j1uF31yGbyGYQngIvqCHRPb8Xb0yfJKb6SqRAVZmO1Fw+24j9qwRD18N2lLa1zoSvPKxB0qbXZCFtPJ1q0VTQtl3lz+x9G31IJVVwoFideOXM2USZ5j4B9S03LH5PR/5yNtfNAjsS39WE/XocZieUoL/2x+CDSgwDawwQhC962nhpD3K6uuWlvBGWsYA1PGwOMQmODtK3NLR0WtbuyoKbGtyNONkp6Q==",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-james inherits james {
  Ssh_authorized_key["James Kelly Personal SSH Key"] {
    ensure => absent,
  }
}

class vera {
  ssh_authorized_key { "vyh@stellar":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDDEJoriaid7yWhU8GtkT/LOtA7N3D6RCWY0CclARvXNSVpkw0U4d7YbQS8NW1loMzTFaRnD2eBj4W0x4ItUwRrM6Nh9ipLgzjUd653aaPsG3GXAa6Ncm9BSYN47Bdlgx7UxuLkVNXEzxQvLjCbNiBQPuFwImPBsNlOolZ79kQ0+91svo/xmqEAX/Q8APsnRCpGnGoILPnb6EH5Nh2PdWpMhbaC5lhXSPPYNp8qIuL3v30JXmugRMgG4cvGSk9zgkZ19Vbhy/dAA6W+V2rWzoYeFVaxLJjkeT+Eb6UYX58dB6niE/WcwJH1mwTPLZsjaXem/fK8r5KOmeLUIpKWYJ25",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-vera inherits vera {
  Ssh_authorized_key["vyh@stellar"] {
    ensure => absent,
  }
}

class jeff {
  ssh_authorized_key { "jeff@ibm":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAABIwAAAQEAxqr1BEypoV9jMxbmbXf/opxu0LfTBLqzZpOVI9tc80fsK3KgRiqD4hwRJK2l1O8X49ySz7mc32TAeFIb2i9raWyf5XzVjPTANl4TClN3Z188HJ0FONudCxdaX10oiQeb1p4e+1S2A63zT4v19etBCgyyCSR/p8Xir/K/bP3STO87ewbAk06LoxCO+o/cFLx70bjqRTaqzrVUBHV/B4GEwMbkTZCT2gT+D0NSVnBXN2mTeZrfLK6SlggfdCl8hVpAs0UFd4+0xQyECTQoRIfiUAqYar/M2hOtX++xPhEIm/ba+eEbG0Lx2LSMbyMleM1cHvnZs5oiyeEyEA0XqXRQfw==",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-jeff inherits jeff {
  Ssh_authorized_key["jeff@ibm"] {
    ensure => absent,
  }
}

class matt {
  ssh_authorized_key { "mattw@Caladan.local":
    ensure => present,
    key    => "AAAAB3NzaC1yc2EAAAADAQABAAACAQDS6Ag6OZAV5ViQH7pjdfBYU9jPyVYt4VuiAI8z5uHTKUcgROJhh9IOWVZRUMfes+vJruA2mVzFB61lzEreBPiRyQuAWDjMGra1nH1notTP1QTkekEhRiW0Qkobcjoa68UPYvsWoodJftGzraGfQJpKM4LdcLZtaG5PD8p5u8fZaWROwcCtJOv6JZGmrVTJ9Bax5jks+ElzoTigqs2lGyv21OryfEX+pOtqOqKjIcYiWvWAQkSM8ekJ9qEdt3irf3GV3cq3CY8iCyJfpgMuI8I0o+9XUDH1f87vSliEmNFSEKD2r8kOQuDtfljKPqmR2OIlgtYQyZVj7/bMw4byW87UuDjC8zPKazIHXQ6EgsAupknHcB9EvlsSG2dpuDAPPx7xfk7iyzntmHbU9kGY/qGN+5583dq9IoQVgEOfbXWFv6PWdSBD072xAP1hl1cSEwRl3p9wbPZmH6nwA+mf3DgKEtzrWjR0xXKa8zN8fSB9EJmKhbGvWFchQ2mSehy2Xz4vymxzcjqFmMfrWWQNxJCEOV4gzmjLeU8XBfBKmvRVV3/9pvAbKkx/vWjiJC7NRKbPBn5O+ht5oPQcVN+hLWxZraIwlHzXnq2rY6jLgiAQf/+uS1vvxG68OergRfWwaThyz+/5M5NAz8d/0q1e+tEFA1R6RxkVOcIjV2qsrtTzaw==",
    type   => ssh-rsa,
    user   => root,
  }
}

class not-matt inherits matt {
  Ssh_authorized_key["mattw@Caladan.local"] {
    ensure => absent,
  }
}

