classdef Algorithms
    %MODFLOODFILL Summary of this class goes here
    %   Detailed explanation goes here

    methods(Static)
           % skel - a skeletonized blob/label
           % startP - the starting point of a passed-in line
           % endP - the end of a passed-in line
           % pts - an array containing all seperation points
           function result = traceLine(skel, startP, endP, mode)
               if (strcmp(mode, "default"))
                   result = Algorithms.trace(skel, startP, endP, zeros(100000,2), 0, 0, 100);
               elseif (strcmp(mode, "centerpt"))
                   whitePx = sum(skel(:));
                   result = Algorithms.trace(skel, startP, endP, zeros(100000,2), 0, 0, whitePx * 0.5);
                   result = result(1, :);
               else
                   error("Unrecognizable input for parameter <mode>. Expected 'default' or 'centerpt', found '" + mode + "' instead.");
               end
           end
           
           function result = trace(skel, startP, endP, pts, ctr, index, threshold)
               sRow = startP(1);
               sCol = startP(2);
               eRow = endP(1);
               eCol = endP(2);
               
               if (sRow == eRow && sCol == eCol)
                   result = pts(1:index, :);
                   return;
               end

               if (mod(ctr, threshold) == 0 && ctr ~= 0)
                   index = index + 1;
                   pts(index, 1) = sRow;
                   pts(index, 2) = sCol;
               end

               skel(sRow, sCol) = 0;

               if (skel(sRow - 1, sCol + 1) ~= 0)
                   result = Algorithms.trace(skel, [sRow - 1, sCol + 1], endP, pts, ctr + 1, index, threshold);
                   return;
               end
               if (skel(sRow + 0, sCol + 1) ~= 0)
                   result = Algorithms.trace(skel, [sRow + 0, sCol + 1], endP, pts, ctr + 1, index, threshold);
                   return;
               end
               if (skel(sRow + 1, sCol + 1) ~= 0)
                   result = Algorithms.trace(skel, [sRow + 1, sCol + 1], endP, pts, ctr + 1, index, threshold);
                   return;
               end
               if (skel(sRow - 1, sCol + 0) ~= 0)
                   result = Algorithms.trace(skel, [sRow - 1, sCol + 0], endP, pts, ctr + 1, index, threshold);
                   return;
               end
               if (skel(sRow + 1, sCol + 0) ~= 0)
                   result = Algorithms.trace(skel, [sRow + 1, sCol + 0], endP, pts, ctr + 1, index, threshold);
                   return;
               end
               if (skel(sRow - 1, sCol - 1) ~= 0)
                   result = Algorithms.trace(skel, [sRow - 1, sCol - 1], endP, pts, ctr + 1, index, threshold);
                   return;
               end
               if (skel(sRow + 0, sCol - 1) ~= 0)
                   result = Algorithms.trace(skel, [sRow + 0, sCol - 1], endP, pts, ctr + 1, index, threshold);
                   return;
               end
               if (skel(sRow + 1, sCol - 1) ~= 0)
                   result = Algorithms.trace(skel, [sRow + 1, sCol - 1], endP, pts, ctr + 1, index, threshold);
                   return;
               end

               result = pts(1:index, :);
               return;
           end
     
           
           function dev = curvature(skelblob, endpoints)
                
               % endpoints of type [row1, col1, row2, col2]
               
                numPixelsInBlob = sum(sum(skelblob==1));
                
                %middlePix = skelblob ;
                %middlePix(endpoints(1:2)) = 0;
                %middlePix(endpoints(3:4)) = 0;
                %countPix = 0 ;
                
                % entferne wiederholt die endpunkte des skeletons, damit
                % nur mehr mittleres Pixel übrig bleibt
%                 while countPix < numPixelsInBlob/2-2
%                     endpix = bwmorph(middlePix, 'endpoints');
%                     endpix1 = find(endpix, 1, 'first');
%                     endpix2 = find(endpix, 1, 'last');
%                     middlePix(endpix1) = 0;
%                     middlePix(endpix2) = 0;
%                     countPix = countPix +1;
%                 end
                
                startPt = endpoints(1:2);
                endPt = endpoints(3:4);
                middlePix = Algorithms.traceLine(skelblob,startPt, endPt,'centerpt');

                %[rowsLastHalfPixels, colsLastHalfPixels] = find(skelblob, numPixelsInBlob/2 , 'last');
                %[rMiddle, cMiddle] = find(middlePix==1);
                
                % berechnet Abstand der jeweiligen Pixel, die
                % in der Mitte der Kurve bzw. Vergleichsgeraden liegen.
                devCol = (endpoints(2) + endpoints(4))/2 - (cMiddle);
                devRow = (endpoints(1) + endpoints(3))/2 - (rMiddle);
          
                % 1st entry = relative distance
                % 2nd & 3rd entry = vector from middle of curve to middle
                % of line
                % 4th & 5th entry = middle point of curve
                distEndp = norm(endpoints(1:2)-endpoints(3:4));
                distToLine = norm([devRow, devCol]);
                relDist = distToLine/distEndp;
                
                dev = [relDist, devRow, devCol, rMiddle, cMiddle];
                
                return;
               
           end
    end
end
